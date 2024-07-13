import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:mobile_app/cubits/pickup_cubit/pickup_cubit.dart';
import 'package:mobile_app/screens/Login.dart';
import 'package:mobile_app/widgets/CustomAppBar.dart';
import 'package:mobile_app/widgets/SearchField.dart';

class PickupsSearchScreen extends StatefulWidget {
  const PickupsSearchScreen({super.key});

  @override
  State<PickupsSearchScreen> createState() => _PickupsSearchScreenState();
}

class _PickupsSearchScreenState extends State<PickupsSearchScreen> {
  final _searchController = TextEditingController();

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
          if (state is LoginSuccess) {
            return BlocConsumer<PickupCubit, PickupState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is PickupsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is PickupsLoaded) {
                  return SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 50.0,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CustomAppBar(
                              title: 'البحث',
                            ),
                            SearchField(
                              controller: _searchController,
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image(
                                  image: AssetImage(
                                      'assets/images/magnifying glass.jpg'),
                                  width: 220,
                                  height: 220,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'ابحث عن طلبك وسيتم عرض النتائج هنا',
                                  style: TextStyle(
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
                } else {
                  return Container();
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
