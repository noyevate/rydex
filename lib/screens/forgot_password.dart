import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:rydex/core/custom_form.dart';
import 'package:rydex/core/reusable_text.dart';
import 'package:rydex/core/space_exs.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rydex/global/global.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rydex/screens/main_screen.dart';
import 'package:rydex/screens/register_page.dart';



class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;


  void _submit() async {
    if (_formKey.currentState!.validate()) {
      await firebaseAuth.sendPasswordResetEmail(
        email: emailTextEditingController.text.trim(),
      ).then((value) async {
        
        await Fluttertoast.showToast(msg: "Rydex have sent an email to your mail");
      }).onError((error, StackTrace) {
        Fluttertoast.showToast(msg: "error occured: \n ${error.toString()}");
      });
    } else {
      Fluttertoast.showToast(msg: "not all fields are valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Column(
              children: [
                Image.asset(darkTheme
                    ? "assets/images/city_dark.png"
                    : "assets/images/city.png"),
                20.h,
                ReuseableText(
                  title: "Forgot Password",
                  style: TextStyle(
                      color:
                          darkTheme ? Colors.amber.shade400 : Colors.lightBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            
                            custom_form(
                              darkTheme: darkTheme,
                              hintText: 'email',
                              prefixIcon: Icon(
                                Icons.email,
                                color: darkTheme
                                    ? Colors.amber.shade400
                                    : Colors.grey,
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "email can\'t be empty";
                                }
                                if (text.length < 2) {
                                  return "Please enter a valid email";
                                }
                                if (EmailValidator.validate(text) == true) {
                                  return null;
                                }
                                if (text.length > 50) {
                                  return "email can\'t be more than 50 characters";
                                }
                                return null;
                              },
                              onChanged: (text) => setState(() {
                                emailTextEditingController.text = text;
                              }),
                            ),
                            10.h,
                            
                            
                                              
                            20.h,
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: darkTheme
                                      ? Colors.amber.shade400
                                      : Colors.lightBlue,
                                  foregroundColor:
                                      darkTheme ? Colors.black : Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  minimumSize: Size(double.infinity, 40)),
                              onPressed: () {
                                _submit();
                              },
                              child: ReuseableText(
                                  title: "Reset Password",
                                  style: TextStyle(fontSize: 15)),
                            ),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}