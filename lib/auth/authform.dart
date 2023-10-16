// import 'dart:js_interop';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';
// import 'package:email_validator/email_validator.dart';

class authform extends StatefulWidget {
  @override
  State<authform> createState() => _authscreenState();
}

class _authscreenState extends State<authform> {
  //--------------------------------------------
  final _formkey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _username = '';
  bool islogin = false;
  //--------------------------------------------
  startauthentication() {
    final validity = _formkey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (validity) {
      _formkey.currentState?.save();
      submitform(_email, _password, _username);
    }
  }

  submitform(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    AuthResult authResult;
    try {
      if (islogin) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String uid = authResult.user.uid;
        await Firestore.instance.collection('users').document(uid).setData({
          'username': username,
          'email': email,
        });
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!islogin)
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        key: ValueKey('Username'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Incorrect Username';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _username = value!;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                            borderSide: new BorderSide(),
                          ),
                          labelText: 'Username',
                          labelStyle: GoogleFonts.roboto(),
                        ),
                      ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Incorrect Email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          borderSide: new BorderSide(),
                        ),
                        labelText: 'Email',
                        labelStyle: GoogleFonts.roboto(),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      // keyboardAppearance: hi,
                      key: ValueKey('Password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Incorrect Password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          borderSide: new BorderSide(),
                        ),
                        labelText: 'Password',
                        labelStyle: GoogleFonts.roboto(),
                      ),
                    ),
                    Container(
                      // color: Colors.blue,
                      padding: const EdgeInsets.all(8.0),
                      width: 100,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ElevatedButton(
                          onPressed: () {},
                          child: islogin
                              ? Text(
                                  'Login',
                                  style: GoogleFonts.roboto(),
                                )
                              : Text(
                                  'Sign-in',
                                  style: GoogleFonts.roboto(),
                                )),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: TextButton(
                        child: islogin
                            ? Text('Not a Memeber')
                            : Text('Already a member?'),
                        onPressed: () {
                          setState(() {
                            islogin = !islogin;
                          });
                        },
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
