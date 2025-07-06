import 'package:flutter/material.dart';
import 'package:rydex/core/reusable_text.dart';
import 'package:rydex/screens/register_page.dart';

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
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => RegisterScreen(),
      ),
    );
  }
}