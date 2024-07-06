import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:mobile_app/models/User.dart';
import 'package:mobile_app/screens/Login.dart';
import 'package:mobile_app/screens/UserProfile.dart';
import 'package:mobile_app/widgets/CustomAppBar.dart';
import 'package:mobile_app/widgets/Menu.dart';
import 'package:mobile_app/widgets/MenuItem.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoginSuccess) {
            final User user = state.user!;

            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 50.0,
                ),
                child: Column(
                  children: [
                    const CustomAppBar(
                      title: 'الإعدادات',
                    ),
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFC6E3FD),
                          radius: 50,
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/user avatar.jpg",
                              width: 90,
                              height: 90,
                              //fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          user.name!,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Menu(
                      items: [
                        MenuItem(
                          name: 'البيانات الشخصية',
                          icon: Icons.account_circle_outlined,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const UserProfileScreen(),
                                ));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).userLogout();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xffFFE2E2),
                        ),
                        overlayColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 226, 148, 148),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 18.0,
                          horizontal: 50,
                        ),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'تسجيل الخروج',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
