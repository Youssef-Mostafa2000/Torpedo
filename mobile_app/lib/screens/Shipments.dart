import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 50.0,
          ),
          child: Column(
            children: [
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'جميع الطلبات',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                    )
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
      ),
    );
  }
}

List<ShipmentsStatusCard> statusList = [];
