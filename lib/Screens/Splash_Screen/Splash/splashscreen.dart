// ignore_for_file: prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mygovern/Screens/Home_Screen/homepage.dart';
import 'package:mygovern/Screens/Splash_Screen/onboarding/wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isNewUser = true;

  int loginNum = 0;
  var emailAddress;
  @override
  void initState() {
    super.initState();
    checkUserType();
    Timer(
        const Duration(seconds: 2),
        () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        loginNum == 1 ? const HomePage() : const Wrapper()),
              )
            });
  }

  checkUserType() {
    var auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((user) {
      if (user != null) {
        user = auth.currentUser;
        emailAddress = user!.email;
        setState(() {
          loginNum = 1;
        });
      } else {
        setState(() {
          loginNum = 2;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            color: Colors.transparent,
            child: Center(
              child: SizedBox(
                height: 60,
                width: 60,
                child: //CircularProgressIndicator(),
                    Lottie.asset('assets/json/lodingtrans.json'),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.black45, Colors.black38],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/jansevalogo.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}
