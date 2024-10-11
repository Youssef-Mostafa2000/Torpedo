import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  final bool? disabled;
  const Button({
    required this.text,
    required this.onPressed,
    this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (disabled == true) ? null : onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            disabled == true
                ? Color(0xffd3d3d3)
                : Theme.of(context).primaryColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: Text(
            text!,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
