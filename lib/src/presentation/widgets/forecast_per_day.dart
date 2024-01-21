import 'package:breeze/config/theme/colors.dart';
import 'package:breeze/core/constants/constants.dart';
import 'package:breeze/src/domain/models/multiple_days_forecast.dart';
import 'package:flutter/material.dart';

/// Widget to display forecast information for a specific day.
class ForecastPerDayWidget extends StatelessWidget {
  final ForecastPerDay forecast;
  final String dayLabel;

  const ForecastPerDayWidget(
      {Key? key, required this.forecast, required this.dayLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.white,
      ),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: colorPrimary,
            ),
            child: Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              dayLabel,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Image.network(
                  forecast.weatherIcon ?? "",
                  width: 70,
                  height: 70,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 4),
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    forecast.weatherDescription ?? "",
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Text(
                    '${forecast.minTemperature?.toStringAsFixed(1)}/${forecast.maxTemperature?.toStringAsFixed(1)}${_getTemperatureUnit()}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Gets the temperature unit based on the unit system.
  _getTemperatureUnit() {
    return forecast.unitSystem == metricUnitSystem
        ? celsiusUnit
        : fahrenheitUnit;
  }
}
