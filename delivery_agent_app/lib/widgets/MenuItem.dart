import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String? name;
  final IconData? icon;
  final Function()? onPressed;

  const MenuItem(
      {required this.name, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Color(0xffF9FBFC),
          ),
          overlayColor: MaterialStateProperty.all(
            Color(0xffC6E3FD),
          ),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          )),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
            ),
            Row(
              children: [
                Text(
                  name!,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
