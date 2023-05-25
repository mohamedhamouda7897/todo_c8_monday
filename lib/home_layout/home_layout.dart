import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c8_monday/screens/login.dart';
import 'package:todo_c8_monday/screens/settings_screen.dart';
import 'package:todo_c8_monday/screens/tasks_screen.dart';
import 'package:todo_c8_monday/screens/widgets/show_add_task_bottom_sheet.dart';

import '../providers/my_provider.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "HomeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          "ToDo ${provider.myUser?.name}",
          style: Theme
              .of(context)
              .textTheme
              .bodyLarge,
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
        shape: StadiumBorder(
          side: BorderSide(color: Colors.white, width: 3),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: index,
          onTap: (value) {
            index = value;
            setState(() {});
          },
          iconSize: 30,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          ],
        ),
      ),
      body: tabs[index],
    );
  }

  List<Widget> tabs = [TasksScreen(), SettingsScreen()];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ShowAddTaskBottomSheet(),
        );
      },
    );
  }
}
