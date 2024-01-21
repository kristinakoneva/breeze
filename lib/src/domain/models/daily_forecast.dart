import 'package:breeze/src/data/remote/models/daily_forecast_response.dart';
import 'package:equatable/equatable.dart';

/// Represents a daily weather forecast with relevant information.
class DailyForecast extends Equatable {
  /// The name of the city for which the forecast is provided.
  final String cityName;

  /// The latitude of the location associated with the forecast.
  final double? latitude;

  /// The longitude of the location associated with the forecast.
  final double? longitude;

  /// The current temperature in the forecast.
  final double? currentTemperature;

  /// The minimum temperature in the forecast.
  final double? minTemperature;

  /// The maximum temperature in the forecast.
  final double? maxTemperature;

  /// The air pressure in the forecast.
  final int? airPressure;

  /// The humidity in the forecast.
  final int? humidity;

  /// The wind speed in the forecast.
  final double? windSpeed;

  /// The description of the weather in the forecast.
  final String? weatherDescription;

  /// The URL representing the weather icon in the forecast.
  final String? weatherIcon;

  /// The unit system used for temperature measurements in the forecast.
  final String unitSystem;

  /// Creates a new instance of [DailyForecast].
  ///
  /// Requires [cityName], [unitSystem], and other parameters are optional.
  const DailyForecast({
    required this.cityName,
    this.latitude,
    this.longitude,
    this.currentTemperature,
    this.minTemperature,
    this.maxTemperature,
    this.airPressure,
    this.humidity,
    this.windSpeed,
    this.weatherDescription,
    this.weatherIcon,
    required this.unitSystem,
  });

  /// Creates a [DailyForecast] instance from a [DailyForecastResponse].
  ///
  /// Requires [response] representing the data from the API and [unitSystem].
  factory DailyForecast.fromDailyForecastResponse(
      DailyForecastResponse response, String unitSystem) {
    String icon = response.weatherDescriptions.isNotEmpty
        ? response.weatherDescriptions[0].icon
        : "";
    icon = "http://openweathermap.org/img/wn/$icon@2x.png";
    return DailyForecast(
      cityName: response.cityName,
      latitude: response.coordinates.latitude,
      longitude: response.coordinates.longitude,
      currentTemperature: response.weather.currentTemperature,
      minTemperature: response.weather.minTemperature,
      maxTemperature: response.weather.maxTemperature,
      airPressure: response.weather.pressure,
      humidity: response.weather.humidity,
      windSpeed: response.wind.speed,
      weatherDescription: response.weatherDescriptions.isNotEmpty
          ? response.weatherDescriptions[0].description
          : "",
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
