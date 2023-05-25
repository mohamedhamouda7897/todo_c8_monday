import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c8_monday/models/task_model.dart';
import 'package:todo_c8_monday/shared/styles/app_colors.dart';
import 'package:todo_c8_monday/shared/styles/my_theme.dart';

import '../../firebase_functions/firebase_function.dart';

class ShowAddTaskBottomSheet extends StatefulWidget {
  @override
  State<ShowAddTaskBottomSheet> createState() => _ShowAddTaskBottomSheetState();
}

class _ShowAddTaskBottomSheetState extends State<ShowAddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();

  // "INSErT ITO Customers value()"
  var selectedDate = DateUtils.dateOnly(DateTime.now());

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add New Task",
              textAlign: TextAlign.center,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter Task title";
                } else if (value.length < 6) {
                  return "please enter at least 6 char";
                }
                return null;
              },
              decoration: InputDecoration(
                  label: Text("Task Title"),
                  errorStyle: Theme
                      .of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.red, fontSize: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: AppColors.primaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: AppColors.primaryColor))),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter Task Description";
                }
                return null;
              },
              decoration: InputDecoration(
                  label: Text("Task Description"),
                  errorStyle: Theme
                      .of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.red, fontSize: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: AppColors.primaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: AppColors.primaryColor))),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Select Date",
                textAlign: TextAlign.start,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.black),
              ),
            ),
            InkWell(
                onTap: () {
                  chooseDate(context);
                },
                child: Text(
                  selectedDate.toString().substring(0, 10),
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * .5,
              child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      TaskModel task = TaskModel(
                          title: titleController.text,
                          time: DateTime
                              .now()
                              .millisecondsSinceEpoch,
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          description: descriptionController.text,
                          status: false,
                          date: selectedDate.millisecondsSinceEpoch);
                      FirebaseFunctions.addTaskToFirestore(task);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Add Task")),
            )
          ],
        ),
      ),
    );
  }

  void chooseDate(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );
    if (chosenDate != null) {
      selectedDate = DateUtils.dateOnly(chosenDate);
      setState(() {});
    }
  }
}
