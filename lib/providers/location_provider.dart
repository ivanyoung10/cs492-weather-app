import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weatherapp/models/location.dart';

import 'package:path_provider/path_provider.dart';

class LocationProvider extends ChangeNotifier {
  Location? location;

  Map<String, Location> savedLocations = {};

  void loadSavedLocations() async {
    final directory = await getApplicationDocumentsDirectory();

    final path = File('${directory.path}/savedLocations.json');

    if (await path.exists()) {
      final jsonString = await path.readAsString();
      final jsonData = jsonDecode(jsonString);

      for (int i = 0; i < jsonData["savedLocations"].length; i++) {
        Map<String, dynamic> location = jsonData["savedLocations"][i];
        savedLocations[location["zip"]] = Location.fromJson(location);
      }
    }

    if (location == null && savedLocations.values.isNotEmpty){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedZip = prefs.getString('zip');
      if (savedZip != null && savedLocations.containsKey(savedZip)){
        location = savedLocations[savedZip];
      }
    }

    notifyListeners();
  }

  void deleteLocation(String zip){
    savedLocations.remove(zip);
    storeSavedLocations();
    notifyListeners();
  }

  void storeSavedLocations() async {
    final directory = await getApplicationDocumentsDirectory();

    final path = File('${directory.path}/savedLocations.json');

    Map<String, dynamic> outputJson = {};

    outputJson["savedLocations"] = savedLocations.values
        .toList()
        .map((location) => location.toJson())
        .toList();

    String outputString = jsonEncode(outputJson);

    await path.writeAsString(outputString);

  final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (location != null){
      prefs.setString("zip", location!.zip);
    }
    else {
      prefs.remove("zip");
    }
  }

  void setLocationFromGps() async {
    location = await getLocationFromGps();

    if (location != null && !savedLocations.containsKey(location!.zip)) {
      savedLocations[location!.zip] = location!;
    }
    storeSavedLocations();
    saveZiptoPrefs();
    notifyListeners();
  }

  void setLocationFromString(String? locationString) async {
    if (locationString != null && locationString.trim().isNotEmpty) {
      location = await getLocationFromString(locationString);
    } else {
      location = null;
    }

    if (location != null && !savedLocations.containsKey(location!.zip)) {
      savedLocations[location!.zip] = location!;
    }
    storeSavedLocations();
    saveZiptoPrefs();
    notifyListeners();
  }

  void setLocation(Location loc){
    location = loc;
    notifyListeners();
    saveZiptoPrefs();
  }

  void saveZiptoPrefs() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (location != null){
      prefs.setString("zip", location!.zip);
    }
    else {
      prefs.remove("zip");
    }
  }
}
