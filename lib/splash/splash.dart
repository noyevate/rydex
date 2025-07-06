import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rydex/assistants/assistant_methods.dart';
import 'package:rydex/core/reusable_text.dart';
import 'package:rydex/global/global.dart';
import 'package:rydex/screens/login_screen.dart';
import 'package:rydex/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    redirect();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ReuseableText(title: "Rydex", style: TextStyle(fontSize: 20, color: Colors.lightBlue, fontWeight: FontWeight.bold),),
      ),
    );
  }
  Future<void> redirect() async {
    Timer(Duration(seconds: 10), () async {
      if(await firebaseAuth.currentUser != null ) {
        firebaseAuth.currentUser != null ? AssistantMethods.readCurrentOnlineUserInfo(): null;
        Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => MainScreen(),
      ),
    );
      } else {
        Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginScreen(),
      ),
    );
      }
    });
    // await Future.delayed(Duration(seconds: 3));
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (BuildContext context) => RegisterScreen(),
    //   ),
    // );
  }
}