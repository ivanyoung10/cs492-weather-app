import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/widgets/location/set_location/location_buttons.dart';
import 'package:weatherapp/widgets/location/saved_locations/saved_locations.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final TextEditingController _locationController = TextEditingController();
  bool _showError = false;

  late LocationProvider _locationActions;

  @override
  void initState() {
    super.initState();
    _locationController.addListener(() {
      if (_locationController.text.isNotEmpty) {
        setState(() {
          _showError = false;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locationActions = context.read<LocationProvider>();
  }

  void _setLocation() {
    if (_locationController.text.isEmpty) {
      setState(() {
        _showError = true;
      });
    } else {
      _locationActions.setLocationFromString(_locationController.text);
    }
  }

  void _clearLocation() {
    _locationActions.setLocationFromString(null);
    _locationController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _locationController,
            decoration: InputDecoration(
              labelText: "Enter Location",
              hintText: "City, State or ZIP code",
              errorText: _showError ? "Please enter a location" : null,
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
            ),
          ),
          LocationButtons(
            setLocation: _setLocation,
            setLocationFromGps: _locationActions.setLocationFromGps,
            clearLocation: _clearLocation,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            child: Text(
              'SAVED LOCATIONS',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Expanded(child: SavedLocations()),
        ],
      ),
    );
  }
}
