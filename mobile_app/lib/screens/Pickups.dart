import 'package:flutter/material.dart';
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
      body: SizedBox(
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
                padding: const EdgeInsets.only(top: 20.0, bottom: 15),
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
                              builder: (context) => const PickupsFilterScreen(),
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
                    PickupCard(
                      id: '#123456',
                      status: 'تم الإلتقاط',
                      numberOfShipments: 10,
                      vehicleType: 'موتوسيكل',
                      deliveryAgentName: 'يوسف مصطفى',
                      deliveryAgentPhoneNumber: '01112367131',
                      date: DateTime(2024, 6, 20),
                    ),
                    PickupCard(
                      id: '#123456',
                      status: 'تم الإلتقاط',
                      numberOfShipments: 10,
                      vehicleType: 'موتوسيكل',
                      deliveryAgentName: 'يوسف مصطفى',
                      deliveryAgentPhoneNumber: '01112367131',
                      date: DateTime(2024, 6, 20),
                    ),
                    PickupCard(
                      id: '#123456',
                      status: 'تم الإلتقاط',
                      numberOfShipments: 10,
                      vehicleType: 'موتوسيكل',
                      deliveryAgentName: 'يوسف مصطفى',
                      deliveryAgentPhoneNumber: '01112367131',
                      date: DateTime(2024, 6, 20),
                    ),
                    PickupCard(
                      id: '#123456',
                      status: 'تم الإلتقاط',
                      numberOfShipments: 10,
                      vehicleType: 'موتوسيكل',
                      deliveryAgentName: 'يوسف مصطفى',
                      deliveryAgentPhoneNumber: '01112367131',
                      date: DateTime(2024, 6, 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
