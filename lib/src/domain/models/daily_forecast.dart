import 'package:breeze/src/data/remote/models/daily_forecast_response.dart';
import 'package:equatable/equatable.dart';

/// Represents a daily weather forecast with relevant information.
class DailyForecast extends Equatable {
  /// The name of the city for which the forecast is provided.
  final String cityName;

  /// The latitude of the location associated with the forecast.
  final double latitude;

  /// The longitude of the location associated with the forecast.
  final double longitude;

  /// The current temperature in the forecast.
  final double currentTemperature;

  /// The minimum temperature in the forecast.
  final double minTemperature;

  /// The maximum temperature in the forecast.
  final double maxTemperature;

  /// The air pressure in the forecast.
  final int airPressure;

  /// The humidity in the forecast.
  final int humidity;

  /// The wind speed in the forecast.
  final double windSpeed;

  /// The description of the weather in the forecast.
  final String weatherDescription;

  /// The URL representing the weather icon in the forecast.
  final String weatherIcon;

  /// The unit system used for temperature measurements in the forecast.
  final String unitSystem;

  /// Creates a new instance of [DailyForecast].
  const DailyForecast({
    required this.cityName,
    required this.latitude,
    required this.longitude,
    required this.currentTemperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.airPressure,
    required this.humidity,
    required this.windSpeed,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.unitSystem,
  });

  /// Creates a [DailyForecast] instance from a [DailyForecastResponse].
  ///
  /// Requires [response] representing the data from the API and [unitSystem].
  factory DailyForecast.fromDailyForecastResponse(
      DailyForecastResponse response, String unitSystem) {
    String icon = response.iconCode;
    icon = "http://openweathermap.org/img/wn/$icon@2x.png";
    return DailyForecast(
      cityName: response.cityName,
      latitude: response.latitude,
      longitude: response.longitude,
      currentTemperature: response.currentTemperature,
      minTemperature: response.minTemperature,
      maxTemperature: response.maxTemperature,
      airPressure: response.pressure,
      humidity: response.humidity,
      windSpeed: response.windSpeed,
      weatherDescription: response.weatherDescription,
      weatherIcon: icon,
      unitSystem: unitSystem,
    );
  }

  @override
  List<Object?> get props => [
        cityName,
        latitude,
        longitude,
        currentTemperature,
        minTemperature,
        maxTemperature,
        airPressure,
        humidity,
        windSpeed,
        weatherDescription,
        weatherIcon,
        unitSystem,
      ];
}
