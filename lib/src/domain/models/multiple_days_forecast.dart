import 'package:breeze/src/data/remote/models/multiple_days_forecast_response.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

/// Represents a multiple days weather forecast with a list of daily forecasts.
class MultipleDaysForecast extends Equatable {
  /// The list of daily forecasts.
  final List<ForecastPerDay> forecasts;

  /// Creates a new instance of [MultipleDaysForecast].
  ///
  /// Requires the [forecasts] parameter representing the list of daily forecasts.
  const MultipleDaysForecast({
    required this.forecasts,
  });

  /// Creates a [MultipleDaysForecast] instance from a [MultipleDaysForecastResponse].
  ///
  /// Requires [input] representing the data from the API and [unitSystem].
  ///
  /// The process involves iterating through the forecast data, calculating daily
  /// minimum and maximum temperatures, associating weather icons and descriptions,
  /// and creating instances of [ForecastPerDay]. The resulting list of daily forecasts
  /// is then used to create the [MultipleDaysForecast] instance.
  factory MultipleDaysForecast.fromMultipleDaysForecastResponse(
      MultipleDaysForecastResponse input, String unitSystem) {
    final List<ForecastPerDay> forecasts = [];
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    DateTime date = formatter.parse(input.forecastsList[0].date);
    double sumMinTemp = 0.0;
    double sumMaxTemp = 0.0;
    int timestampsPerDayCounter = 0;
    String icon = '';
    String description = '';

    for (Forecast forecast in input.forecastsList) {
      int counter = 0;
      if (formatter.parse(forecast.date) != date) {
        // If the date of the forecast is different from the date of the previous forecast,
        // create a new instance of ForecastPerDay and add it to the list of forecasts.
        if (icon.contains("n")) {
          icon = icon.replaceAll("n", "d");
        }
        forecasts.add(
          ForecastPerDay(
            date: date,
            weatherIcon: "http://openweathermap.org/img/wn/$icon@2x.png",
            weatherDescription: description,
            minTemperature: sumMinTemp / timestampsPerDayCounter,
            maxTemperature: sumMaxTemp / timestampsPerDayCounter,
            unitSystem: unitSystem,
          ),
        );

        if (counter == 4) {
          // We've already added the forecasts for the next 3 days, so we can stop here.
          break;
        } else {
          counter++;
        }

        // Resetting the counters and variables for the next day.
        timestampsPerDayCounter = 0;
        icon = forecast.weatherDescriptions?.first.icon ?? '';
        description = forecast.weatherDescriptions?.first.description ?? '';
        date = formatter.parse(forecast.date);
        sumMinTemp = forecast.weather.minTemperature;
        sumMaxTemp = forecast.weather.maxTemperature;
      } else {
        // If the date of the forecast is the same as the date of the previous forecast,
        // add the forecast data to the counters and variables.
        sumMaxTemp += forecast.weather.maxTemperature;
        sumMinTemp += forecast.weather.minTemperature;
        timestampsPerDayCounter++;
        icon = forecast.weatherDescriptions?.first.icon ?? '';
        description = forecast.weatherDescriptions?.first.description ?? '';
        date = formatter.parse(forecast.date);
      }
    }

    // Removing today's forecast because we need to display only the forecasts for the next 3 days.
    forecasts.removeAt(0);

    return MultipleDaysForecast(
      forecasts: forecasts,
    );
  }

  @override
  List<Object?> get props => [
        forecasts,
      ];
}

/// Represents a forecast for a specific day.
class ForecastPerDay extends Equatable {
  /// The date of the forecast.
  final DateTime? date;

  /// The URL representing the weather icon for the forecast.
  final String? weatherIcon;

  /// The description of the weather for the forecast.
  final String? weatherDescription;

  /// The minimum temperature for the forecast.
  final double? minTemperature;

  /// The maximum temperature for the forecast.
  final double? maxTemperature;

  /// The unit system used for temperature measurements in the forecast.
  final String unitSystem;

  /// Creates a new instance of [ForecastPerDay].
  ///
  /// Requires various parameters representing the forecast details.
  const ForecastPerDay({
    this.date,
    this.weatherIcon,
    this.weatherDescription,
    this.minTemperature,
    this.maxTemperature,
    required this.unitSystem,
  });

  @override
  List<Object?> get props => [
        date,
        weatherIcon,
        weatherDescription,
        minTemperature,
        maxTemperature,
        unitSystem,
      ];
}
