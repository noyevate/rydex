import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:rydex/core/custom_form.dart';
import 'package:rydex/core/reusable_text.dart';
import 'package:rydex/core/space_exs.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rydex/global/global.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rydex/screens/main_screen.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;


  void _submit() async {
    if (_formKey.currentState!.validate()) {
      await firebaseAuth.signInWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim() 
      ).then((auth) async {
        currentUser = auth.user;
        

        await Fluttertoast.showToast(msg: "successfully logged in");
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
      }).catchError((errorMessage) {
        Fluttertoast.showToast(msg: "error occured: \n $errorMessage");
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
                  title: "Register",
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
                            
                            
                            10.h,
                            custom_form(
                              obscureText: !_passwordVisible,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: darkTheme
                                      ? Colors.amber.shade400
                                      : Colors.grey,
                                ),
                              ),
                              darkTheme: darkTheme,
                              hintText: 'confirm passsword',
                              prefixIcon: Icon(
                                Icons.password,
                                color: darkTheme
                                    ? Colors.amber.shade400
                                    : Colors.grey,
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "password can\'t be empty";
                                }
                                if (text.length < 6) {
                                  return "Please enter a valid password";
                                }

                                if (text.length > 100) {
                                  return "password can\'t be more than 100 characters";
                                }
                                return null;
                              },
                              onChanged: (text) => setState(() {
                                passwordTextEditingController.text = text;
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
                                  title: "Register",
                                  style: TextStyle(fontSize: 15)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ReuseableText(
                                  title: "don\'t have an account?",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                                10.s,
                                ReuseableText(
                                  title: "Sign up",
                                  style: TextStyle(
                                      color: darkTheme
                                          ? Colors.amber.shade400
                                          : Colors.lightBlue,
                                      fontSize: 15),
                                ),
                              ],
                            )
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