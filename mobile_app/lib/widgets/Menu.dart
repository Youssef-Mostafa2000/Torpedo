// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/MenuItem.dart';

class Menu extends StatelessWidget {
  List<MenuItem> items;
  Menu({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return MenuItem(
          name: item.name,
          icon: item.icon,
          onPressed: item.onPressed,
        );
      }).toList(),
    );
  }
}
