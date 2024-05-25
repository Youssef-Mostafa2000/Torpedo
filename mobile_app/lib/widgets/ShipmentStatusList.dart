import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/ShipmentsStatusCard.dart';

class ShipmentStatusList extends StatelessWidget {
  const ShipmentStatusList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShipmentsStatusCard(
              color: Theme.of(context).primaryColor,
              name: 'جديد',
              number: 20,
            ),
            ShipmentsStatusCard(
              color: const Color(0xff13CE66),
              name: 'جميع الطلبات',
              number: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShipmentsStatusCard(
              color: const Color(0xffEA8A4E),
              name: 'قيد الإنتظار',
              number: 20,
            ),
            ShipmentsStatusCard(
              color: const Color(0xff2D8EFF),
              name: 'تم التسليم',
              number: 20,
            ),
          ],
        ),
      ],
    );
  }
}
