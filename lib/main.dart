import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prototype/pages/pages.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        '/meal_details': (context) => MealDetails(),
        '/search': (context) => SearchPage(),
        '/edit_profile': (context) => EditProfile(),
      },
    );
  }
}
