import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/cubits/auth_cubit/auth_cubit.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthCubit()..checkLoginStatus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: '/login',
        title: 'Torpedo',
        theme: AppTheme(),
        home: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            }
          },
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is LoginSuccess) {
                return const HomeScreen();
              } else {
                return const LoginScreen();
              }
            },
          ),
        ),
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
      ),
    );
  }
}
