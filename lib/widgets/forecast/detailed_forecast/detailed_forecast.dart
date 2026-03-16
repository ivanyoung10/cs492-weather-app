import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/forecast.dart';
import 'package:weatherapp/providers/forecast_provider.dart';
import 'package:weatherapp/providers/theme_provider.dart';
import 'package:weatherapp/widgets/forecast/detailed_forecast/detailed_forecast_text.dart';

class DetailedForecast extends StatefulWidget {
  const DetailedForecast({super.key});

  @override
  State<DetailedForecast> createState() => _DetailedForecastState();
}

class _DetailedForecastState extends State<DetailedForecast> {
  String? _imageUrl;
  Forecast? _lastForecast;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final activeForecast = context.watch<ForecastProvider>().activeForecast;

    if (activeForecast != null && activeForecast != _lastForecast) {
      _lastForecast = activeForecast;
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeForecast = context.watch<ForecastProvider>().activeForecast;
    final themeProvider = context.watch<ThemeProvider>();

    if (activeForecast == null) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Text(
            'Select a forecast to see details',
            style: TextStyle(color: themeProvider.greyColor),
          ),
        ),
      );
    }

    return ExcludeSemantics(
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Card(
          elevation: 3,
          margin: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: themeProvider.daytimeColor,
                ),
              ),
              DetailedForecastText(activeForecast: activeForecast),
            ],
          ),
        ),
      ),
    );
  }
}
