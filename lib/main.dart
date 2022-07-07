import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prototype/pages/pages.dart';
import 'firebase_options.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/home' : (context) => HomePage(),
        '/login' : (context) => LoginPage(),
        '/register' : (context) => RegisterPage(),
      },
    );
  }
}
