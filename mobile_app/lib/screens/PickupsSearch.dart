import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:mobile_app/cubits/pickup_cubit/pickup_cubit.dart';
import 'package:mobile_app/models/Pickup.dart';
import 'package:mobile_app/screens/Login.dart';
import 'package:mobile_app/widgets/CustomAppBar.dart';
import 'package:mobile_app/widgets/PickupCard.dart';
import 'package:mobile_app/widgets/SearchField.dart';

class PickupsSearchScreen extends StatefulWidget {
  const PickupsSearchScreen({super.key});

  @override
  State<PickupsSearchScreen> createState() => _PickupsSearchScreenState();
}

class _PickupsSearchScreenState extends State<PickupsSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Pickup> pickups = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

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
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 50.0,
                ),
                child: Column(
                  children: [
                    CustomAppBar(
                      title: 'البحث',
                    ),
                    SearchField(
                      controller: _searchController,
                      onChanged: (val) {
                        BlocProvider.of<PickupCubit>(context)
                            .searchPickups(val);
                      },
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    BlocConsumer<PickupCubit, PickupState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is PickupsInitial) {
                          return const Column(
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
                          );
                        } else if (state is PickupsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is PickupsLoaded) {
                          pickups = state.pickups!;

                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: pickups.length,
                              itemBuilder: (context, index) => PickupCard(
                                id: pickups[index].id.toString(),
                                status: pickups[index].status ?? '',
                                numberOfShipments:
                                    pickups[index].shipmentsCount ?? 0,
                                vehicleType: pickups[index].vehicleType ?? '',
                                deliveryAgentName:
                                    pickups[index].deliveryAgent != null
                                        ? pickups[index].deliveryAgent!.name
                                        : '',
                                deliveryAgentPhoneNumber:
                                    pickups[index].deliveryAgent != null
                                        ? pickups[index]
                                            .deliveryAgent!
                                            .phoneNumber
                                            .toString()
                                        : '',
                                date: pickups[index].date ?? DateTime.now(),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
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
