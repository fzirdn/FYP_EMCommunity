import 'package:emcommunity_fyp/ui/login_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EMCommunity',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),     
      home: LoginPage(),
    );
  }
}

