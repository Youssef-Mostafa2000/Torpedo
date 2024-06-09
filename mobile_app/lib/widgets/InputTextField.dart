import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final controller;
  final String label;
  final String hint;
  final Widget? suffixIcon;
  final Widget? suffix;
  //final Widget? prefix;
  final String? prefixText;
  final bool? obsecureText;
  final bool? enabled;
  final bool? required;

  InputTextField({
    required this.controller,
    required this.label,
    required this.hint,
    this.suffixIcon,
    this.suffix,
    //this.prefix,
    this.prefixText,
    this.obsecureText,
    this.enabled,
    this.required,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            required == true
                ? const Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
                : Container(),
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
          textDirection: TextDirection.rtl,
          enabled: enabled,
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
            //prefix: prefix != null ? prefix : null,
            prefixText: prefixText != null ? prefixText : '',
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
            disabledBorder: OutlineInputBorder(
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
