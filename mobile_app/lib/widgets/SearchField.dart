import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final controller;
  final Function(String)? onChanged;
  SearchField({
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: 14,
        color: Theme.of(context).primaryColor,
      ),
      cursorColor: Theme.of(context).primaryColor,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.search_outlined,
          // color: Theme.of(context).primaryColor,
          size: 25,
        ),
        hintText: 'اكتب كود الطلب هنا',
        hintStyle: TextStyle(
            // color: Theme.of(context).primaryColor,
            // fontSize: 14,
            ),
        hintTextDirection: TextDirection.rtl,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 18,
        ),
        fillColor: const Color(0xffF4F4F4),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            style: BorderStyle.none,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
