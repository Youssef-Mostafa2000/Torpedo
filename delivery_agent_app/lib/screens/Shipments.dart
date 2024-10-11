import 'package:delivery_agent_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:delivery_agent_app/cubits/shipment_cubit/shipment_cubit.dart';
import 'package:delivery_agent_app/models/Shipment.dart';
import 'package:delivery_agent_app/screens/Login.dart';
import 'package:delivery_agent_app/widgets/CustomAppBar.dart';
import 'package:delivery_agent_app/widgets/SearchField.dart';
import 'package:delivery_agent_app/widgets/ShipmentCard.dart';
import 'package:delivery_agent_app/widgets/ShipmentsScreenStatusList.dart';
import 'package:delivery_agent_app/widgets/ShipmentsStatusCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShipmentsScreen extends StatefulWidget {
  const ShipmentsScreen({super.key});

  @override
  State<ShipmentsScreen> createState() => _ShipmentsScreenState();
}

class _ShipmentsScreenState extends State<ShipmentsScreen> {
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
            return BlocConsumer<ShipmentCubit, ShipmentState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ShipmentsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ShipmentsLoaded) {
                  final List<Shipment> shipments = state.shipments ?? [];
                  return SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 50.0,
                      ),
                      child: Column(
                        children: [
                          const CustomAppBar(
                            title: 'الشحنات',
                          ),
                          SearchField(
                            controller: _searchController,
                            onChanged: (val) {},
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const ShipmentsScreenStatusList(),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 15),
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
                                    /*Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ShipmentsFilterScreen(),
                                        ));*/
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
                            child: shipments.length > 0
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: shipments.length,
                                    itemBuilder: (context, index) =>
                                        ShipmentCard(
                                      id: shipments[index].id.toString(),
                                      name:
                                          shipments[index].receiver!.name ?? '',
                                      city:
                                          shipments[index].receiver!.city ?? '',
                                      district:
                                          shipments[index].receiver!.district ??
                                              '',
                                      phoneNumber: shipments[index]
                                              .receiver!
                                              .phoneNumber ??
                                          '',
                                      status: shipments[index].status ?? 'جديد',
                                      date: shipments[index].date ??
                                          DateTime.now(),
                                    ),
                                  )
                                : const Center(
                                    child: Text(
                                      'لا يوجد طلبات',
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
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

List<ShipmentsStatusCard> statusList = [];
