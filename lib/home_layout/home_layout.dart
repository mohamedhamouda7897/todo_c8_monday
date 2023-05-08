import 'package:flutter/material.dart';

class HomeLayout extends StatelessWidget {
  static const String routeName = "HomeLayout";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ToDo App",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
