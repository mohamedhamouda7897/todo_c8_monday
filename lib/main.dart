import 'package:flutter/material.dart';
import 'package:todo_c8_monday/shared/styles/my_theme.dart';

import 'home_layout/home_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: MyThemeData.darkTheme,
      theme: MyThemeData.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: HomeLayout.routeName,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
