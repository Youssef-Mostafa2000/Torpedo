import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  DateTime? date;
  DatePicker({required this.date});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
          initialDate: widget.date,
          currentDate: widget.date,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Theme.of(context).primaryColor,
                  onSurface: Theme.of(context).primaryColor,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColor),
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null && picked != widget.date) {
          setState(() {
            widget.date = picked;
          });
        }
        //print(widget.date);
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
                '${widget.date!.year.toString()}-${widget.date!.month.toString()}-${widget.date!.day.toString()}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const Icon(
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
