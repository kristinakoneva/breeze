import 'package:breeze/core/constants/constants.dart';
import 'package:breeze/src/domain/models/daily_forecast.dart';
import 'package:flutter/material.dart';

/// Widget to display the current weather information.
class CurrentWeatherWidget extends StatelessWidget {
  final DailyForecast dailyForecast;

  const CurrentWeatherWidget({Key? key, required this.dailyForecast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Flex(
            mainAxisAlignment: MainAxisAlignment.center,
            direction: Axis.horizontal,
            children: [
              const Icon(Icons.location_on),
              Container(
                width: 200,
                margin: const EdgeInsets.only(left: 8),
                child: Text(
                  dailyForecast.cityName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ],
          ),
          Container(
            //color: Colors.white,
            padding: const EdgeInsets.all(26),
            margin: const EdgeInsets.symmetric(horizontal: 42),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Colors.white,
            ),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Image.network(
                  dailyForecast.weatherIcon,
                ),
                Text(
                  dailyForecast.weatherDescription,
                  style: const TextStyle(color: Colors.black, fontSize: 28),
                ),
                Flex(
                  mainAxisSize: MainAxisSize.min,
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${dailyForecast.currentTemperature}',
                      style: const TextStyle(color: Colors.black, fontSize: 38),
                    ),
                    Text(
                      _getTemperatureUnit(),
                      style: const TextStyle(color: Colors.black, fontSize: 32),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Gets the temperature unit based on the unit system.
  _getTemperatureUnit() {
    return dailyForecast.unitSystem == metricUnitSystem
        ? celsiusUnit
        : fahrenheitUnit;
  }
}
