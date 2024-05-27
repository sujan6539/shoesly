import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrimaryButton extends StatelessWidget {
  VoidCallback onPressed;
  String title;
  IconData? iconData;
  bool enabled;

  PrimaryButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.iconData,
      this.enabled = true});

  var backgroundProperty = WidgetStateProperty.resolveWith<Color>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey; // Use grey color when disabled
      }
      return Colors.black; // Use default color when enabled
    },
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: backgroundProperty,
        ),
        onPressed: enabled ? onPressed : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              iconData == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: FaIcon(
                        iconData,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ));
  }
}
