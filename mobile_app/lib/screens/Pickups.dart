import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:mobile_app/cubits/pickup_cubit/pickup_cubit.dart';
import 'package:mobile_app/models/Pickup.dart';
import 'package:mobile_app/screens/Login.dart';
import 'package:mobile_app/screens/PickupsFilter.dart';
import 'package:mobile_app/widgets/CustomAppBar.dart';
import 'package:mobile_app/widgets/PickupCard.dart';
import 'package:mobile_app/widgets/PickupsScreenStatusList.dart';
import 'package:mobile_app/widgets/SearchField.dart';

class PickupsScreen extends StatefulWidget {
  const PickupsScreen({super.key});

  @override
  State<PickupsScreen> createState() => _PickupsScreenState();
}

class _PickupsScreenState extends State<PickupsScreen> {
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
                } else if (state is PickupsLoaded) {
                  List<Pickup> pickups = state.pickups ?? [];
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
                          const CustomAppBar(
                            title: 'طلبات الإلتقاط',
                          ),
                          SearchField(
                            controller: _searchController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const PickupsScreenStatusList(),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 15),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'جميع الطلبات',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PickupsFilterScreen(),
                                        ));
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: Color(0xff033f73),
                                    ),
                                    width: 100,
                                    height: 35,
                                    child: const Row(
                                      textDirection: TextDirection.rtl,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.filter_list,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'تصنيف',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: pickups.length,
                              itemBuilder: (context, index) {
                                return PickupCard(
                                  id: pickups[index].id.toString(),
                                  status: pickups[index].status ?? '',
                                  numberOfShipments:
                                      pickups[index].shipmentsCount,
                                  vehicleType: pickups[index].vehicleType,
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
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  if (state is PickupsFailure) print(state.errorMessage);
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
