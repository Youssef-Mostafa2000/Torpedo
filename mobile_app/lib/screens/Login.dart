import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/InputTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obsecure = true;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obsecure = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/logo2.png'),
                width: 120,
                height: 120,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'تسجيل الدخول إلى حسابك',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              InputTextField(
                controller: _emailController,
                label: 'البريد الإلكتروني',
                hint: 'قم بإدخال بريدك الإلكتروني',
                suffixIcon: Icon(
                  Icons.email_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InputTextField(
                controller: _passwordController,
                label: 'كلمة المرور',
                hint: 'قم بإدخال كلمة المرور',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obsecure ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _obsecure = !_obsecure;
                    });
                  },
                ),
                obsecureText: _obsecure,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4.0,
                      right: 4.0,
                    ),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'هل نسيت كلمة المرور ؟',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 30,
                  ),
                  child: Text(
                    'تسجيل الدخول',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'انشاء حساب جديد ',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    'لا يوجد لديك حساب ؟',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
