import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/PickupsScreenStatusCard.dart';

class PickupsScreenStatusList extends StatelessWidget {
  const PickupsScreenStatusList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PickupsScreenStatusCard(
              color: Theme.of(context).primaryColor,
              name: 'جديد',
              number: 20,
            ),
            const PickupsScreenStatusCard(
              color: Colors.green,
              name: 'تم الإلتقاط',
              number: 20,
            ),
            const PickupsScreenStatusCard(
              color: Colors.red,
              name: 'تم الإلغاء',
              number: 20,
            ),
          ],
        ),
      ],
    );
  }
}
