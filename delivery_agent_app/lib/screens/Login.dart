import 'package:delivery_agent_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:delivery_agent_app/screens/Home.dart';
import 'package:delivery_agent_app/widgets/InputTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneNumberController = TextEditingController(text: "1123581831");
  final _passwordController = TextEditingController(text: "123456");
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
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'يرجى إدخال رقم هاتف صحيح';
                          return null;
                        },
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
                        label: 'كلمة المرور',
                        hint: 'قم بإدخال كلمة المرور',
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'يرجى إدخال كلمة المرور';
                          return null;
                        },
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
                          if (_formKey.currentState!.validate()) {
                            await context.read<AuthCubit>().deliveryAgentLogin({
                              "phoneNumber":
                                  int.parse(_phoneNumberController.text),
                              "password": _passwordController.text
                            });
                            print(BlocProvider.of<AuthCubit>(context).state);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
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
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
