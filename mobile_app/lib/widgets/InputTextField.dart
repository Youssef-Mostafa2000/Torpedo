import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final controller;
  final String label;
  final String hint;
  final Widget? suffixIcon;
  final Widget? suffix;
  final bool? obsecureText;

  InputTextField({
    required this.controller,
    required this.label,
    required this.hint,
    this.suffixIcon,
    this.suffix,
    this.obsecureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              '*',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          obscureText: obsecureText == true,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).primaryColor,
          ),
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            suffix: suffix != null ? suffix : null,
            suffixIcon: suffixIcon != null ? suffixIcon : null,
            hintText: hint,
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
        ),
      ],
    );
  }
}
