import 'package:delivery_agent_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:delivery_agent_app/models/DeliveryAgent.dart';
import 'package:delivery_agent_app/screens/Login.dart';
import 'package:delivery_agent_app/widgets/Button.dart';
import 'package:delivery_agent_app/widgets/CustomAppBar.dart';
import 'package:delivery_agent_app/widgets/InputTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  bool editEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editEnabled = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            final DeliveryAgent deliveryAgent = state.deliveryAgent!;
            _firstNameController.text = deliveryAgent.name!;
            _lastNameController.text = deliveryAgent.name!;
            _phoneNumberController.text = deliveryAgent.phoneNumber.toString();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 50.0,
                ),
                child: Column(
                  children: [
                    const CustomAppBar(
                      title: 'البيانات الشخصية',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InputTextField(
                      controller: _firstNameController,
                      label: 'الإسم الأول',
                      hint: '',
                      enabled: editEnabled,
                      suffixIcon: Icon(
                        Icons.person_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputTextField(
                      controller: _lastNameController,
                      label: 'الإسم الأخير',
                      hint: '',
                      enabled: editEnabled,
                      suffixIcon: Icon(
                        Icons.person_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputTextField(
                      controller: _phoneNumberController,
                      label: 'رقم الموبايل',
                      hint: '',
                      enabled: editEnabled,
                      suffixIcon: Icon(
                        Icons.phone,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Button(
                      text: 'تعديل',
                      onPressed: () {
                        if (!editEnabled) {
                          setState(() {
                            editEnabled = true;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Button(
                      text: 'حفظ',
                      onPressed: () {
                        // update api
                        setState(() {
                          editEnabled = false;
                        });
                      },
                      disabled: !editEnabled,
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
