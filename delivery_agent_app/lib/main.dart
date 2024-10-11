import 'package:delivery_agent_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:delivery_agent_app/cubits/pickup_cubit/pickup_cubit.dart';
import 'package:delivery_agent_app/cubits/shipment_cubit/shipment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:delivery_agent_app/themes/AppTheme.dart';
import 'package:delivery_agent_app/screens/Home.dart';
import 'package:delivery_agent_app/screens/Login.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //create: (BuildContext context) => AuthCubit()..checkLoginStatus(),
      providers: [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit()..checkLoginStatus(),
        ),
        BlocProvider<ShipmentCubit>(
          create: (BuildContext context) => ShipmentCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => PickupCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
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
          '/home': (context) => const HomeScreen(),
          '/login': (context) => const LoginScreen(),
          /*'/splash': (context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/onBoarding': (context) => const OnBoardingScreen(),
          '/shipments': (context) => const ShipmentsScreen(),
          '/shipments-filter': (context) => const ShipmentsFilterScreen(),
          '/shipments-search': (context) => const ShipmentsSearch(),
          '/settings': (context) => const SettingsScreen(),
          '/user-profile': (context) => const UserProfileScreen(),
          '/wallet': (context) => const WalletScreen(),
          '/create-shipment': (context) => const CreateShipmentScreen(),*/
        },
      ),
    );
  }
}
