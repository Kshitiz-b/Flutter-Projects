import 'package:flashchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                  colour: Colors.blueAccent,
                  title: 'Register',
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    // print(email);
                    // print(password);
                    try {
                      final newUser = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      Navigator.pushNamed(context, ChatScreen.id);

                      setState(() {
                        showSpinner = false;
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        //print('The password provided is too weak.');
                        setState(() {
                          showSpinner = false;
                        });
                        kGetAlertDialog(
                            context, 'The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        //print('The account already exists for that email.');
                        setState(() {
                          showSpinner = false;
                        });
                        kGetAlertDialog(context,
                            'The account already exists for that Email.\nEnter a different Email Address');
                      } else if (e.code == 'invalid-email') {
                        //print(e.code);
                        setState(() {
                          showSpinner = false;
                        });
                        kGetAlertDialog(context, 'Invalid Email Address.');
                      } else {
                        setState(() {
                          showSpinner = false;
                        });
                        kGetAlertDialog(context, e.code);
                      }
                    } catch (e) {
                      //print(e);
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
