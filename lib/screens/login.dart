import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_c8_monday/firebase_functions/firebase_function.dart';
import 'package:todo_c8_monday/home_layout/home_layout.dart';
import 'package:todo_c8_monday/screens/create_account.dart';

import '../providers/my_provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login";

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/login_g.png",
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@gmail+\.com+")
                                .hasMatch(value!);
                            if (value.isEmpty) {
                              return "Please enter mail";
                            } else if (!emailValid) {
                              return "please enter valid mail";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text("Email Address"),
                            errorStyle: GoogleFonts.quicksand(
                                fontSize: 12, color: Colors.red),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(18)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(18)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter password";
                            } else if (value.length < 6) {
                              return "Please enter at least 6 char";
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.black54,
                            ),
                            label: Text("Password"),
                            errorStyle: GoogleFonts.quicksand(
                                fontSize: 12, color: Colors.red),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(18)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(18)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                FirebaseFunctions.login(emailController.text,
                                    passwordController.text, (message) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Auth Error"),
                                        content: Text(message),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Ok"))
                                        ],
                                      );
                                    },
                                  );
                                }, () {
                                  provider.initUser();
                                  Navigator.pushReplacementNamed(
                                      context, HomeLayout.routeName);
                                });
                              }
                            },
                            child: Text("Login")),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Don't have an account?",
                        style: GoogleFonts.quicksand(color: Colors.black54),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, CreateAccount.routeName);
                          },
                          child: Text("Create Account"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
