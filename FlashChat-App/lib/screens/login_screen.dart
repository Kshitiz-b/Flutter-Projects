import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                  //labelText: 'Email',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                  //labelText: 'Password',
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  colour: Colors.lightBlueAccent,
                  title: 'Log In',
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final existingUser = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email, password: password);
                      Navigator.pushNamed(context, ChatScreen.id);

                      setState(() {
                        showSpinner = false;
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        //print('No user found for that email.');
                        setState(() {
                          showSpinner = false;
                        });
                        kGetAlertDialog(context,
                            'No User Found For That Email.\nPlease Register First.');
                      } else if (e.code == 'wrong-password') {
                        //print('Wrong password provided for that user.');
                        setState(() {
                          showSpinner = false;
                        });
                        kGetAlertDialog(context, 'Incorrect Email/Password.');
                      } else if (e.code == 'invalid-email') {
                        //print('Please enter a correct email');
                        setState(() {
                          showSpinner = false;
                        });
                        kGetAlertDialog(
                            context, 'Please Enter A Correct Email Address.');
                      } else {
                        setState(() {
                          showSpinner = false;
                        });
                        kGetAlertDialog(context, e.code);
                      }
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                      });
                      kGetAlertDialog(context, e.toString());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
