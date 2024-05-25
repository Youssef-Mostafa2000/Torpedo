import 'package:flutter/material.dart';

class ShipmentsStatusCard extends StatelessWidget {
  final Color? color;
  final String? name;
  final int? number;
  ShipmentsStatusCard(
      {required this.color, required this.name, required this.number});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            width: 155,
            height: 74,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            width: 153,
            height: 72,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    number.toString(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    name!,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
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
