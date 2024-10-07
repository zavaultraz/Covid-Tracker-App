import 'package:covid_tracker/UI/home.dart';
import 'package:covid_tracker/UI/intropage.dart';
import 'package:flutter/material.dart';

import 'UI/Login.dart';
import 'UI/Register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
      routes: {
        '/test': (context) => const CovidTrackerApp(username: '', password: ''),
        '/register' : (context) => RegisterScreen(),
        '/login' : (context) => LoginScreen(),
      },

    );
  }
}
