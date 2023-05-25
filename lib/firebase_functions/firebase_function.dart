import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_c8_monday/models/task_model.dart';
import 'package:todo_c8_monday/models/user_model.dart';

import '../shared/components/constants.dart';


class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (taskModel, _) {
        return taskModel.toJson();
      },
    );
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.COLLECTION_NAME)
        .withConverter<MyUser>(
      fromFirestore: (snapshot, _) {
        return MyUser.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }

  static Future<MyUser?> readUserFromFirestore(String id) async {
    DocumentSnapshot<MyUser> userDoc = await getUsersCollection().doc(id).get();

    return userDoc.data();
  }

  static Future<void> addUserToFirestore(MyUser myUser) {
    var collection = getUsersCollection();
    var docRef = collection.doc(myUser.id);
    return docRef.set(myUser);
  }

  static Future<void> addTaskToFirestore(TaskModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTaskFromFirestore(DateTime date) {
    return getTasksCollection()
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",
        isEqualTo: DateUtils
            .dateOnly(date)
            .millisecondsSinceEpoch)
        .orderBy("time")
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getTasksCollection().doc(id).delete();
  }

  static Future<void> updateTask(String id, TaskModel task) {
    return getTasksCollection().doc(id).update(task.toJson());
  }

  static void createAccount(String name, int age, String email, String password,
      Function afterCreate) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser myUser =
      MyUser(name: name, age: age, email: email, id: credential.user!.uid);
      addUserToFirestore(myUser).then((value) {
        afterCreate();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static void login(String email, password, Function dialog,
      Function afterLogin) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      afterLogin();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        dialog(e.message);
      } else if (e.code == 'wrong-password') {
        dialog(e.message);
      }
    }
  }
}
