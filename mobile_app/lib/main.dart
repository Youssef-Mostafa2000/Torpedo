import 'package:flutter/material.dart';
import 'package:mobile_app/screens/Home.dart';
import 'package:mobile_app/screens/Login.dart';
import 'package:mobile_app/screens/OnBoarding.dart';
import 'package:mobile_app/screens/Splash.dart';
import 'package:mobile_app/themes/AppTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      title: 'Torpedo',
      theme: AppTheme(),
      //home: const OnBoardingScreen(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
