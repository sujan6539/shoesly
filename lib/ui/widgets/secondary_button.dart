import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  VoidCallback onPressed;
  String title;

  SecondaryButton({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ));
  }
}
