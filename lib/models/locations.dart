import 'dart:ffi';

import 'package:geocoding/geocoding.dart' as geocoding;

class Location {
  String city;
  String state;
  String country;
  String zip;
  double latitude;
  double longitude;

  Location(
      {required this.city,
      required this.state,
      required this.country,
      required this.zip,
      required this.latitude,
      required this.longitude});
}

void mapJsonToLocation(Location l) {}

// change this function to return a single location object
Future<Location> getLocationFromString(String s) async {
  List<geocoding.Location> locations = await geocoding.locationFromAddress(s);

  print(locations);

  List<geocoding.Placemark> placemarks = await geocoding
      .placemarkFromCoordinates(locations[0].latitude, locations[0].longitude);

  print(placemarks);

  return Location(
      city: placemarks[0].locality ?? "",
      state: placemarks[0].administrativeArea ?? "",
      country: placemarks[0].country ?? "",
      zip: placemarks[0].postalCode ?? "",
      latitude: locations[0].latitude,
      longitude: locations[0].longitude);
}
