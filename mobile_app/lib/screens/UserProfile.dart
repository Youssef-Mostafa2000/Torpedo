import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:mobile_app/models/Customer.dart';
import 'package:mobile_app/models/User.dart';
import 'package:mobile_app/screens/Login.dart';
import 'package:mobile_app/widgets/Button.dart';
import 'package:mobile_app/widgets/CustomAppBar.dart';
import 'package:mobile_app/widgets/InputTextField.dart';

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
    // _firstNameController.value = TextEditingValue(text: 'يوسف');
    // _lastNameController.value = TextEditingValue(text: 'مصطفى');
    // _phoneNumberController.value = TextEditingValue(text: '201112367131+');
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
            final Customer customer = state.customer!;
            _firstNameController.text = customer.name!;
            _lastNameController.text = customer.name!;
            _phoneNumberController.text = customer.phoneNumber.toString();
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
                    /*const SizedBox(
                  height: 20,
                ),*/
                    /*Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'البيانات الشخصية',
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),*/
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
