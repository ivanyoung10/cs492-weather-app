import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:weatherapp/models/location.dart';

import 'package:path_provider/path_provider.dart';

import 'dart:io';

class LocationProvider extends ChangeNotifier {
  Location? location;

  Map<String, Location> savedLocations = {};

  void loadSavedLocations() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = File('${directory.path}/savedLocations.json');

    if (await path.exists()) {
      final jsonString = await path.readAsString();
      final jsonData = jsonDecode(jsonString);

      for (int i = 0; i < jsonData['savedLocations'].length; i++) {
        Map<String, dynamic> location = jsonData['savedLocations'][i];
        savedLocations[location["zip"]] = Location.fromJson(location);
      }
    }
  }

  void storeSavedLocations() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = File('${directory.path}/savedLocations.json');

    Map<String, dynamic> outputJson = {};
    outputJson['savedLocations'] = savedLocations.values
        .toList()
        .map((location) => location.toJson())
        .toList();
    String outputString = jsonEncode(outputJson);
    path.writeAsString(outputString);
  }

  void setLocationFromGps() async {
    location = await getLocationFromGps();

    if (location != null && !savedLocations.containsKey(location!.zip)) {
      savedLocations[location!.zip] = location!;
    }

    storeSavedLocations();
    notifyListeners();
  }

  void setLocation(String? locationString) async {
    if (locationString != null && locationString.trim().isNotEmpty) {
      location = await getLocationFromString(locationString);
    } else {
      location = null;
    }

    if (location != null && !savedLocations.containsKey(location!.zip)) {
      savedLocations[location!.zip] = location!;
    }

    storeSavedLocations();
    notifyListeners();
  }
}
