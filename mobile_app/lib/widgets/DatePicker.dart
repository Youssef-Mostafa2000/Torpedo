import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  final String? date;
  DatePicker({required this.date});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
          initialDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Theme.of(context).primaryColor,
                  onSurface: Theme.of(context).primaryColor,
                ),
              ),
              child: child!,
            );
          },
        );
      },
      child: Container(
        width: 160,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xffF4F4F4),
            style: BorderStyle.solid,
          ),
          color: const Color(0xffF4F4F4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                date!,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Icon(
                Icons.calendar_month,
                // size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
