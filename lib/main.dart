import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rydex/screens/login_screen.dart';

import 'package:rydex/splash/splash.dart';
import 'package:rydex/theme_provider/theme_provider.dart';

Future<void>main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rydex',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: myThemes.lightTheme,
      darkTheme: myThemes.darkTheme,
      home:  LoginScreen(),
    );
  }
}
