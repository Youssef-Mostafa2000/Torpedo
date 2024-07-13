import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:mobile_app/cubits/pickup_cubit/pickup_cubit.dart';
import 'package:mobile_app/screens/Home.dart';
import 'package:mobile_app/screens/Login.dart';
import 'package:mobile_app/widgets/Button.dart';
import 'package:mobile_app/widgets/CustomAppBar.dart';
import 'package:mobile_app/widgets/InputTextField.dart';
import 'package:mobile_app/widgets/SelectionMenu.dart';

class CreatePickupScreen extends StatefulWidget {
  const CreatePickupScreen({super.key});

  @override
  State<CreatePickupScreen> createState() => _CreatePickupScreenState();
}

class _CreatePickupScreenState extends State<CreatePickupScreen> {
  final pickupsNumController = TextEditingController();
  final pickupsNotesController = TextEditingController();
  String vehicleType = '';
  final List<String> vehicleTypes = [
    'Moto',
    'car',
  ];

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
            return BlocProvider<PickupCubit>(
              create: (context) => PickupCubit(),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const CustomAppBar(
                          title: 'طلب التقاط جديد',
                        ),
                        InputTextField(
                          controller: pickupsNumController,
                          label: 'عدد الشحنات',
                          hint: 'أدخل عدد الشحنات',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              'وسيلة النقل',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                        SelectionMenu(
                          hint: 'اختر وسيلة النقل',
                          textDirection: TextDirection.rtl,
                          currentChoice: vehicleType,
                          onChanged: (val) {
                            setState(() {
                              vehicleType = val;
                            });
                          },
                          items: vehicleTypes,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InputTextField(
                          controller: pickupsNotesController,
                          label: 'ملاحظات',
                          hint: '',
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Button(
                          text: 'حفظ',
                          onPressed: () {
                            // create pickup
                            BlocProvider.of<PickupCubit>(context).createPickup({
                              'shipmentsCount':
                                  int.parse(pickupsNumController.text),
                              'vehicleType': vehicleType,
                              'notes': pickupsNotesController.text,
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
        // child: ,
      ),
    );
  }
}
