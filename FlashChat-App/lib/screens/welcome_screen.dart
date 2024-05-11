import 'package:flashchat/constants.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flashchat/components/rounded_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 90,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                AnimatedTextKit(
                  //repeatForever: true,
                  totalRepeatCount: 10,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      speed: const Duration(milliseconds: 100),
                      textStyle: const TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                colour: Colors.lightBlueAccent,
                title: 'Log In',
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, LoginScreen.id);
                  });
                }),
            RoundedButton(
                colour: Colors.blueAccent,
                title: 'Register',
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  });
                }),
            const SizedBox(
              height: 20.0,
            ),
            Wrap(alignment: WrapAlignment.end, children: [
              const Text(
                '- By ',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
              InkWell(
                onTap: () async {
                  Uri url = Uri.parse('https://github.com/Kshitiz-b');
                  try {
                    await launchUrl(url);
                  } catch (e) {
                    print(e);
                    kGetAlertDialog(context, 'Could not launch $url');
                  }
                },
                child: const Text(
                  'Kshitiz-b',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.lightBlueAccent),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
