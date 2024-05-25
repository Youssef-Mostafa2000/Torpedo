import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  final String? date;
  const DatePicker({required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xffF4F4F4),
          style: BorderStyle.solid,
        ),
        color: const Color(0xffF4F4F4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            date!,
            style: TextStyle(fontSize: 16),
          ),
          Icon(Icons.calendar_month),
        ],
      ),
    );
  }
}
