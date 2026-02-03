import 'dart:convert';
import 'package:http/http.dart' as http;

class Forecast {
  int temperature;
  String windSpeed;
  String windDirection;
  String name;
  String shortForecast;
  String detailedForecast;
  bool isDaytime;
  String imagePath;

  Forecast(
      {required this.temperature,
      required this.windSpeed,
      required this.windDirection,
      required this.name,
      required this.shortForecast,
      required this.detailedForecast,
      required this.isDaytime,
      required this.imagePath});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
        temperature: json["temperature"],
        windSpeed: json['windSpeed'],
        windDirection: json["windDirection"],
        name: json["name"],
        shortForecast: json["shortForecast"],
        detailedForecast: json["detailedForecast"],
        isDaytime: json["isDaytime"],
        imagePath: getAssetFromDescription(json["shortForecast"]));
  }
}

Future<List<Forecast>> getForecastsByLocation(double lat, double long) async {
  String forecastUrl = "https://api.weather.gov/points/$lat,$long";
  http.Response forecastResponse = await http.get(Uri.parse(forecastUrl));
  final Map<String, dynamic> forecastJson = jsonDecode(forecastResponse.body);

  http.Response forecastDetailResponse =
      await http.get(Uri.parse(forecastJson["properties"]["forecast"]));
  final Map<String, dynamic> forecastDetailJson =
      jsonDecode(forecastDetailResponse.body);

  List<Forecast> forecasts = [];

  List<dynamic> periods = forecastDetailJson["properties"]["periods"];

  for (int i = 0; i < periods.length; i++) {
    Map<String, dynamic> f = periods[i];
    forecasts.add(Forecast.fromJson(f));
  }

  return forecasts;
}

String getAssetFromDescription(String description) {
  description = description.toLowerCase();
  if (description.contains("mostly") || description.contains("sunny")) {
     return "assets/icons/mostly_clear_day.svg";
  }
  if (description.contains("mostly") || description.contains("cloudy")) {
     return "assets/icons/mostly_cloudy_day.svg";
  }
   if (description.contains("partly") || description.contains("cloudy")) {
     return "assets/icons/partly_cloudy_day.svg";
  }
  if (description.contains("partly") || description.contains("sunny")) {
     return "assets/icons/partly_clear_day.svg";
  }

  if (description.contains("sunny") || description.contains("clear")) {
    return "assets/icons/clear_day.svg";
  }
  if (description.contains("rain") && description.contains("snow")) {
    return "assets/icons/mixed_rain_snow.svg";
  }
  if (description.contains("sleet") || description.contains("hail")) {
    return "assets/icons/sleet_hail.svg";
  }
  if (description.contains("fog") || description.contains("dust") || description.contains("hazy")) {
    return "assets/icons/haze_fog_dust_smoke.svg";
  }
  if (description.contains("rain showers")) {
    return "assets/icons/showers_rain.svg";
  }
  if (description.contains("light rain")) {
    return "assets/icons/drizzle.svg";
  }
  if (description.contains("heavy rain")) {
    return "assets/icons/heavy_rain.svg";
  }
  if (description.contains("freezing rain")) {
    return "assets/icons/icy.svg";
  }
  if (description.contains("light snow")) {
    return "assets/icons/flurries.svg";
  }
  if (description.contains("rain")) {
    return "assets/icons/showers_rain.svg";
  }
  if (description.contains("heavy snow")) {
    return "assets/icons/blizzard.svg";
  }
  if (description.contains("snow")) {
    return "assets/icons/showers_snow.svg";
  }
  if (description.contains("thunderstorms")) {
    return "assets/icons/strong_thunderstorms.svg";
  }
  if (description.contains("blowing snow")) {
    return "assets/icons/blowing_snow.svg";
  }
  if (description.contains("snow showers")) {
    return "assets/icons/showers_snow.svg";
  }
  if (description.contains("cloudy")) {
    return "assets/icons/cloudy.svg";
  }

  return "assets/icons/tornado.svg";
}
