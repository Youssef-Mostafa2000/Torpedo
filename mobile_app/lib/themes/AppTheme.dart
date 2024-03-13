import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

ThemeData AppTheme() => ThemeData(
      primaryColor: const Color(0xff033f73),
      appBarTheme: const AppBarTheme(
        color: Color(0xff033f73),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xff033f73)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xff033f73)),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xff033f73),
      ),
      switchTheme: const SwitchThemeData(
        thumbColor: MaterialStatePropertyAll(Color(0xff033f73)),
        trackColor: MaterialStatePropertyAll(Color.fromARGB(255, 46, 114, 173)),
      ),
      // 0xffe98b4d --> secondary color
      //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //useMaterial3: true,
    );
