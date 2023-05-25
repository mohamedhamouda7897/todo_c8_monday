import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/extra/color.dart';
import 'package:flutter/material.dart';
import 'package:todo_c8_monday/firebase_functions/firebase_function.dart';
import 'package:todo_c8_monday/models/task_model.dart';
import 'package:todo_c8_monday/screens/widgets/task_item.dart';
import 'package:todo_c8_monday/shared/styles/app_colors.dart' as co;

class TasksScreen extends StatefulWidget {
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          inactiveDates: [
            DateTime(2023, 5, 12),
            DateTime(2023, 5, 10),
          ],
          selectionColor: co.AppColors.primaryColor,
          selectedTextColor: Colors.white,
          height: 120,
          onDateChange: (newDate) {
            // New date selected
            setState(() {
              date = newDate;
            });
          },
        ),
        StreamBuilder(
          stream: FirebaseFunctions.getTaskFromFirestore(date),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Column(
                children: [
                  Text("Something went wrong"),
                  ElevatedButton(onPressed: () {}, child: Text("Try Again"))
                ],
              );
            }
            List<TaskModel> tasks =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
            if (tasks.isEmpty) {
              return Center(child: Text("No Tasks"));
            }
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItem(tasks[index]);
                },
                itemCount: tasks.length,
              ),
            );
          },
        )
      ],
    );
  }
}
