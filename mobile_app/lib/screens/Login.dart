import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:mobile_app/screens/Home.dart';
import 'package:mobile_app/widgets/InputTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obsecure = true;
  final _formKey = GlobalKey<FormState>();
  bool pnoneNumberValid = true;
  bool passwordValid = true;
  String phoneNumberErrorMessage = '';
  String passwordErrorMessage = '';
  String errorMessage = '';

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obsecure = true;
  }

  bool isPhoneNumberValid(String phoneNumber) {
    if (!phoneNumber.contains(RegExp(r'^(010|011|012|015)\d{8}$'))) {
      /*setState(() {
        errorMessage = 'رقم الهاتف غير صحيح';
      });*/
      return true;
    }
    return true;
  }

  bool isPasswordValid(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*()_+{}\[\]:;"<>,.?/~\\]'))) {
      return false;
    }
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    return true;
  }

  void login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },

          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: _formKey,
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
                        required: true,
                        controller: _phoneNumberController,
                        maxLength: 11,
                        //error: !pnoneNumberValid,
                        //errorMessage: phoneNumberErrorMessage,
                        /*onChanged: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              pnoneNumberValid = false;
                              phoneNumberErrorMessage =
                                  'يرجى إدخال رقم هاتف صحيح';
                            });
                          } else if (!isPhoneNumberValid(
                              _phoneNumberController.text)) {
                            setState(() {
                              pnoneNumberValid = false;
                              phoneNumberErrorMessage = 'خطأ';
                            });
                          } else {
                            setState(() {
                              pnoneNumberValid = true;
                              phoneNumberErrorMessage = '';
                            });
                          }
                        },*/
                        /*validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'يرجى إدخال رقم هاتف صحيح';
                          return null;
                        }*/
                        label: 'رقم الهاتف',
                        hint: 'قم بإدخال رقم الهاتف',
                        suffixIcon: Icon(
                          Icons.email_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InputTextField(
                        required: true,
                        controller: _passwordController,
                        // error: !passwordValid,
                        // errorMessage: passwordErrorMessage,
                        /*onChanged: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              passwordValid = false;
                              passwordErrorMessage =
                                  'يرجى إدخال كلمة مرور صالحة';
                            });
                          } else if (!isPasswordValid(
                              _passwordController.text)) {
                            setState(() {
                              passwordValid = false;
                              passwordErrorMessage = 'خطأ';
                            });
                          } else {
                            setState(() {
                              passwordValid = true;
                              passwordErrorMessage = '';
                            });
                          }
                        },*/
                        /*validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'يرجى إدخال كلمة المرور';
                          return null;
                        },*/
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
                        onPressed: () async {
                          await context.read<AuthCubit>().userLogin({
                            "phoneNumber":
                                int.parse(_phoneNumberController.text),
                            "password": _passwordController.text
                          });
                          /*await BlocProvider.of<AuthCubit>(context).userLogin({
                            "phoneNumber":
                                int.parse(_phoneNumberController.text),
                            "password": _passwordController.text
                          });*/
                          //BlocProvider.of<AuthCubit>(context)
                          /*Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ));*/
                          /*if (isPhoneNumberValid(_phoneNumberController.text) &&
                              isPasswordValid(_passwordController.text)) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Center(
                                  child: Text(
                                    errorMessage,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }*/
                          /*if (_formKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ));
                          }*/ /*else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error')),
                            );
                          }*/
                        },
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
          },
          // child:
        ),
      ),
    );
  }
}
