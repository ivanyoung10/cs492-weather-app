import 'package:flutter/material.dart';
import '../models/forecast.dart';

class DetailedForecast extends StatelessWidget {
  const DetailedForecast({
    super.key,
    required Forecast? activeForecast,
  }) : _activeForecast = activeForecast;

  final Forecast? _activeForecast;

  @override
  Widget build(BuildContext context) {
    final accentColor = _activeForecast != null && _activeForecast.isDaytime
        ? Colors.orange
        : Colors.indigo;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: 300,
        width: double.infinity, 
        child: Card(
          color: accentColor,
          child:Column(
          children: [
            Text(_activeForecast != null ? _activeForecast.name: "", style: TextStyle(color: Colors.white),),
            Text(_activeForecast != null ? _activeForecast.detailedForecast: "", style: TextStyle(color: Colors.white,)),
          ],
        )
      ),
      )
    );
  }
}