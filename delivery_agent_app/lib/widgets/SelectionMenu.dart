// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SelectionMenu extends StatelessWidget {
  final String? hint;
  final TextDirection? textDirection;
  final void Function(dynamic)? onChanged;
  final List<String>? items;
  late String? currentChoice;

  SelectionMenu({
    required this.hint,
    required this.textDirection,
    required this.onChanged,
    required this.items,
    this.currentChoice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xffF4F4F4),
          style: BorderStyle.solid,
        ),
        color: const Color(0xffF4F4F4),
      ),
      child: Directionality(
        textDirection: textDirection!,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            elevation: 1,
            value: currentChoice == '' ? null : currentChoice,
            hint: Text(
              hint!,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            padding: EdgeInsets.all(2),

            // alignment: Alignment.centerRight,

            icon: Icon(Icons.keyboard_arrow_down),
            items: items!
                .map<DropdownMenuItem<String>>(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(item),
                    ),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
