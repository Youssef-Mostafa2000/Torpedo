import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // timer for navigation to main screen
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/onBoarding');
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xffdde5e7),
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: const Center(
          child: Image(
            image: AssetImage('assets/images/logo2.png'),
            width: 220,
            height: 220,
          ),
        ),
      ),
    );
  }
}
