import 'package:flutter/material.dart';
import 'package:todo_list/auth/authform.dart';

class authscreen extends StatefulWidget {
  @override
  State<authscreen> createState() => _authscreenState();
}

class _authscreenState extends State<authscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentication')),
      body: authform(),
    );
  }
}
