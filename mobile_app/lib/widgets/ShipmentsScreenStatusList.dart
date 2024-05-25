import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/ShipmentsScreenStatusCard.dart';

class ShipmentsScreenStatusList extends StatelessWidget {
  const ShipmentsScreenStatusList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShipmentsScreenStatusCard(
              color: Theme.of(context).primaryColor,
              name: 'إنتظار الشحن',
              number: 20,
            ),
            ShipmentsScreenStatusCard(
              color: const Color(0xffFFCC3D),
              name: 'في المخزن',
              number: 20,
            ),
            ShipmentsScreenStatusCard(
              color: const Color(0xff13CE66),
              name: 'تم التسليم',
              number: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShipmentsScreenStatusCard(
              color: const Color(0xffEA8A4E),
              name: 'قيد التوصيل',
              number: 20,
            ),
            ShipmentsScreenStatusCard(
              color: Colors.lightBlue,
              name: 'إعادة التوصيل',
              number: 20,
            ),
            ShipmentsScreenStatusCard(
              color: Colors.red,
              name: 'تعذر التسليم',
              number: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
