import 'package:flutter/material.dart';

class PickupsScreenStatusCard extends StatelessWidget {
  final Color? color;
  final String? name;
  final int? number;
  final Function()? onTap;
  const PickupsScreenStatusCard(
      {required this.color,
      required this.name,
      required this.number,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            width: 102,
            height: 82,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            width: 100,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.only(right: 0, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name!,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    number.toString(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
