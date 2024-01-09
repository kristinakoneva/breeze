import 'package:breeze/src/data/remote/models/multiple_days_forecast.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class MultipleDaysForecast extends Equatable {
  final List<ForecastPerDay> forecasts;

  const MultipleDaysForecast({
    required this.forecasts,
  });

  factory MultipleDaysForecast.fromMultipleDaysForecastResponse(
      MultipleDaysForecastResponse input) {
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
          ),
        );

        if (counter == 4) {
          break;
        } else {
          counter++;
        }
        timestampsPerDayCounter = 0;
        icon = forecast.weatherDescriptions?.first.icon ?? '';
        description = forecast.weatherDescriptions?.first.description ?? '';
        date = formatter.parse(forecast.date);
        sumMinTemp = forecast.weather.minTemperature;
        sumMaxTemp = forecast.weather.maxTemperature;
      } else {
        sumMaxTemp += forecast.weather.maxTemperature;
        sumMinTemp += forecast.weather.minTemperature;
        timestampsPerDayCounter++;
        icon = forecast.weatherDescriptions?.first.icon ?? '';
        description = forecast.weatherDescriptions?.first.description ?? '';
        date = formatter.parse(forecast.date);
      }
    }

    // Removing today's forecast
    forecasts.removeAt(0);

    return MultipleDaysForecast(forecasts: forecasts);
  }

  @override
  List<Object?> get props => [
        forecasts,
      ];
}

class ForecastPerDay extends Equatable {
  final DateTime? date;
  final String? weatherIcon;
  final String? weatherDescription;
  final double? minTemperature;
  final double? maxTemperature;

  const ForecastPerDay({
    this.date,
    this.weatherIcon,
    this.weatherDescription,
    this.minTemperature,
    this.maxTemperature,
  });

  @override
  List<Object?> get props => [
        date,
        weatherIcon,
        weatherDescription,
        minTemperature,
        maxTemperature,
      ];
}
