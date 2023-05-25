import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c8_monday/firebase_functions/firebase_function.dart';
import 'package:todo_c8_monday/models/user_model.dart';

class MyProvider extends ChangeNotifier {
  MyUser? myUser;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  void initUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    myUser = await FirebaseFunctions.readUserFromFirestore(firebaseUser!.uid);
    notifyListeners();
  }
}
