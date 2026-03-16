import 'package:flutter/material.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({
    super.key,
    required this.description,
    required this.callbackFunction,
    this.icon,
  });

  final String description;
  final void Function() callbackFunction;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: callbackFunction,
              icon: Icon(icon, size: 16),
              label: Text(description),
            )
          : ElevatedButton(
              onPressed: callbackFunction,
              child: Text(description),
            ),
    );
  }
}