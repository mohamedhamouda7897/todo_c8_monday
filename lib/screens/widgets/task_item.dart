import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_c8_monday/firebase_functions/firebase_function.dart';
import 'package:todo_c8_monday/models/task_model.dart';
import 'package:todo_c8_monday/shared/styles/app_colors.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;

  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.transparent)),
      child: Slidable(
        startActionPane: ActionPane(motion: BehindMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFunctions.deleteTask(task.id);
            },
            label: "Delete",
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
          ),
          SlidableAction(
            onPressed: (context) {},
            label: "Edit",
            icon: Icons.edit,
            backgroundColor: Colors.blue,
          ),
        ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 3,
                decoration: BoxDecoration(
                    color: task.status ? AppColors.greenColor : Colors.blue,
                    borderRadius: BorderRadius.circular(4)),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: task.status
                            ? AppColors.greenColor
                            : AppColors.primaryColor),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .65,
                    child: Text(
                      task.description,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black54),
                    ),
                  )
                ],
              ),
              Spacer(),
              task.status
                  ? Text(
                      "Done!",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.greenColor),
                    )
                  : InkWell(
                      onTap: () {
                        task.status = true;
                        FirebaseFunctions.updateTask(task.id, task);
                      },
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 18),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Icon(
                            Icons.done,
                            size: 30,
                            color: Colors.white,
                          )),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
