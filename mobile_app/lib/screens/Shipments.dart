import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/cubits/shipment_cubit/shipment_cubit.dart';
import 'package:mobile_app/models/Shipment.dart';
import 'package:mobile_app/screens/ShipmentsFilter.dart';
import 'package:mobile_app/widgets/CustomAppBar.dart';
import 'package:mobile_app/widgets/SearchField.dart';
import 'package:mobile_app/widgets/ShipmentCard.dart';
import 'package:mobile_app/widgets/ShipmentsScreenStatusCard.dart';
import 'package:mobile_app/widgets/ShipmentsScreenStatusList.dart';
import 'package:mobile_app/widgets/ShipmentsStatusCard.dart';

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
      body: BlocConsumer(
        listener: (context, state) {
          if (state is ShipmentsInitial) {}
        },
        builder: (context, state) {
          if (state is ShipmentsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ShipmentsLoaded) {
            final List<Shipment> shipments = state.shipments;
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const ShipmentsScreenStatusList(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 15),
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
                                        const ShipmentsFilterScreen(),
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                      child: ListView(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          ShipmentCard(
                            id: '123456',
                            name: 'يوسف مصطفى زكريا يوسف',
                            city: 'القاهرة',
                            district: 'عين شمس',
                            phoneNumber: '01112367131',
                            status: 'جديد',
                            date: DateTime(2024, 5, 1),
                          ),
                          ShipmentCard(
                            id: '123456',
                            name: 'يوسف مصطفى زكريا يوسف',
                            city: 'القاهرة',
                            district: 'عين شمس',
                            phoneNumber: '01112367131',
                            status: 'جديد',
                            date: DateTime(2024, 5, 1),
                          ),
                          ShipmentCard(
                            id: '123456',
                            name: 'يوسف مصطفى زكريا يوسف',
                            city: 'القاهرة',
                            district: 'عين شمس',
                            phoneNumber: '01112367131',
                            status: 'جديد',
                            date: DateTime(2024, 5, 1),
                          ),
                          ShipmentCard(
                            id: '123456',
                            name: 'يوسف مصطفى زكريا يوسف',
                            city: 'القاهرة',
                            district: 'عين شمس',
                            phoneNumber: '01112367131',
                            status: 'جديد',
                            date: DateTime(2024, 5, 1),
                          )
                        ],
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
        /*child: SizedBox(
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
                ),
                const SizedBox(
                  height: 20,
                ),
                const ShipmentsScreenStatusList(),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 15),
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
                                    const ShipmentsFilterScreen(),
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
                            mainAxisAlignment: MainAxisAlignment.center,
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
                  child: ListView(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      ShipmentCard(
                        id: '123456',
                        name: 'يوسف مصطفى زكريا يوسف',
                        city: 'القاهرة',
                        district: 'عين شمس',
                        phoneNumber: '01112367131',
                        status: 'جديد',
                        date: DateTime(2024, 5, 1),
                      ),
                      ShipmentCard(
                        id: '123456',
                        name: 'يوسف مصطفى زكريا يوسف',
                        city: 'القاهرة',
                        district: 'عين شمس',
                        phoneNumber: '01112367131',
                        status: 'جديد',
                        date: DateTime(2024, 5, 1),
                      ),
                      ShipmentCard(
                        id: '123456',
                        name: 'يوسف مصطفى زكريا يوسف',
                        city: 'القاهرة',
                        district: 'عين شمس',
                        phoneNumber: '01112367131',
                        status: 'جديد',
                        date: DateTime(2024, 5, 1),
                      ),
                      ShipmentCard(
                        id: '123456',
                        name: 'يوسف مصطفى زكريا يوسف',
                        city: 'القاهرة',
                        district: 'عين شمس',
                        phoneNumber: '01112367131',
                        status: 'جديد',
                        date: DateTime(2024, 5, 1),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),*/
      ),
    );
  }
}

List<ShipmentsStatusCard> statusList = [];
