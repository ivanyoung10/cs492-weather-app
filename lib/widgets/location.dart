import 'package:flutter/material.dart';

import '../models/location.dart';

class LocationWidget extends StatelessWidget {
  LocationWidget({
    super.key,
    required Location? location,
    required this.setLocation,
    required this.setLocationFromGps,
  }) : _location = location;

  final Location? _location;
  final TextEditingController _locationController = TextEditingController();
  final void Function(String) setLocation;
  final void Function() setLocationFromGps;

  void _setLocation() {
    setLocation(_locationController.text);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: "Enter Location")),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 14.0,
            children: [
              ElevatedButton(onPressed: _setLocation, child: Text(style: TextStyle(color: Colors.white), "Set Location")),
              ElevatedButton(onPressed: setLocationFromGps, child: Text("Set Location From GPS"))
            ],
          ),
        ),
        Text(_location != null
            ? "${_location.city}, ${_location.state} ${_location.zip}"
            : "No Location..."),
      ],
    );
  }
}