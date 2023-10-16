// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/auth/authscreen.dart';
import 'package:todo_list/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, usersnapshot) {
          if (usersnapshot.hasData) {
            return Home();
          } else {
            return authscreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
        brightness: Brightness.dark,
      ),
    );
  }
}
