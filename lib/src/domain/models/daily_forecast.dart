import 'package:breeze/src/data/data_sources/remote/models/daily_forecast.dart';
import 'package:equatable/equatable.dart';

class DailyForecast extends Equatable {
  String cityName;
  double? latitude;
  double? longitude;
  double? currentTemperature;
  double? minTemperature;
  double? maxTemperature;
  int? airPressure;
  int? humidity;
  double? windSpeed;
  String? weatherDescription;

  DailyForecast({
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
  });

  factory DailyForecast.fromDailyForecastResponse(
      DailyForecastResponse response) {
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
      ];
}
