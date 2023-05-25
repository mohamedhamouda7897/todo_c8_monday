import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_c8_monday/firebase_functions/firebase_function.dart';
import 'package:todo_c8_monday/home_layout/home_layout.dart';
import 'package:todo_c8_monday/screens/login.dart';

import '../providers/my_provider.dart';

class CreateAccount extends StatelessWidget {
  static const String routeName = "creteAccount";
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/login_bg.png",
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
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text("Name"),
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
                          controller: ageController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter age";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: Text("Age"),
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
                            errorStyle: GoogleFonts.quicksand(
                                fontSize: 12, color: Colors.red),
                            label: Text("Email Address"),
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
                            errorStyle: GoogleFonts.quicksand(
                                fontSize: 12, color: Colors.red),
                            label: Text("Password"),
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
                                FirebaseFunctions.createAccount(
                                    nameController.text,
                                    int.parse(ageController.text),
                                    emailController.text,
                                    passwordController.text, () {
                                  provider.initUser();
                                  Navigator.pushReplacementNamed(
                                      context, HomeLayout.routeName);
                                });
                              }
                            },
                            child: Text("Create Account")),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "I've an account?",
                        style: GoogleFonts.quicksand(color: Colors.black54),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          child: Text("Login"))
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
