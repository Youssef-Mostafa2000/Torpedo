import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

ThemeData AppTheme() => ThemeData(
      fontFamily: 'BalooBhaijaan2',
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        labelSmall: TextStyle(
          color: Colors.white,
        ),
        labelMedium: TextStyle(
          color: Colors.white,
        ),
        labelLarge: TextStyle(
          color: Colors.white,
        ),
      ),
      primaryColor: const Color(0xff033f73),
      appBarTheme: const AppBarTheme(
        color: Color(0xff033f73),
        foregroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xff033f73)),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Color(0xffdde5e7),
        selectionHandleColor: Color(0xff033f73),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xff033f73)),
          foregroundColor: MaterialStateProperty.all(Colors.white),
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
