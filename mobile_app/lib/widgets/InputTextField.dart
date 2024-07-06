import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatelessWidget {
  final controller;
  final String label;
  final String hint;
  final Widget? suffixIcon;
  final Widget? suffix;
  final String? prefixText;
  final bool? obsecureText;
  final bool? enabled;
  final bool? required;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final bool? error;
  final String? errorMessage;
  final int? maxLength;

  InputTextField({
    required this.controller,
    required this.label,
    required this.hint,
    this.suffixIcon,
    this.suffix,
    this.prefixText,
    this.obsecureText,
    this.enabled,
    this.required,
    this.validator,
    this.onChanged,
    this.error,
    this.errorMessage,
    this.maxLength,
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
          validator: validator,
          onChanged: onChanged,
          textDirection: TextDirection.rtl,
          enabled: enabled,
          controller: controller,
          obscureText: obsecureText == true,
          maxLength: maxLength,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).primaryColor,
          ),
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            suffix: suffix != null ? suffix : null,
            suffixIcon: suffixIcon != null ? suffixIcon : null,
            prefixText: prefixText != null ? prefixText : '',
            counterText: '',
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
              borderSide: (error == true)
                  ? const BorderSide(
                      color: Colors.red,
                      width: 1,
                    )
                  : const BorderSide(style: BorderStyle.none),
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
                color: (error == true)
                    ? Colors.red
                    : Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ),
        (error == true)
            ? Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
