import 'package:flutter/material.dart';
import 'package:mobile_app/screens/Home.dart';
import 'package:mobile_app/screens/Login.dart';
import 'package:mobile_app/screens/OnBoarding.dart';
import 'package:mobile_app/screens/Settings.dart';
import 'package:mobile_app/screens/Shipments.dart';
import 'package:mobile_app/screens/ShipmentsFilter.dart';
import 'package:mobile_app/screens/ShipmentsSearch.dart';
import 'package:mobile_app/screens/Splash.dart';
import 'package:mobile_app/screens/UserProfile.dart';
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
      initialRoute: '/user-profile',
      title: 'Torpedo',
      theme: AppTheme(),
      //home: const OnBoardingScreen(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/onBoarding': (context) => const OnBoardingScreen(),
        '/shipments': (context) => const ShipmentsScreen(),
        '/shipments-filter': (context) => const ShipmentsFilterScreen(),
        '/shipments-search': (context) => const ShipmentsSearch(),
        '/settings': (context) => const SettingsScreen(),
        '/user-profile': (context) => const UserProfileScreen(),
      },
    );
  }
}
