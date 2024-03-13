import 'package:flutter/material.dart';
import 'package:mobile_app/screens/Home.dart';
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
      title: 'Torpedo',
      theme: AppTheme(),
      home: const HomeScreen(),
    );
  }
}
