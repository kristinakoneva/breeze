import 'package:breeze/src/data/remote/models/daily_forecast.dart';
import 'package:equatable/equatable.dart';

class DailyForecast extends Equatable {
  final String cityName;
  final double? latitude;
  final double? longitude;
  final double? currentTemperature;
  final double? minTemperature;
  final double? maxTemperature;
  final int? airPressure;
  final int? humidity;
  final double? windSpeed;
  final String? weatherDescription;
  final String? weatherIcon;

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
  });

  factory DailyForecast.fromDailyForecastResponse(
      DailyForecastResponse response) {
    String icon = response.weatherDescriptions.isNotEmpty
        ? response.weatherDescriptions[0].icon
        : "";
    icon = "http://openweathermap.org/img/wn/$icon@2x.png";
    return DailyForecast(
      cityName: response.cityName,
      latitude: response.coordinates.latitude,
      longitude: response.coordinates.longitude,
      currentTemperature: response.weather.currentTemperature,
      // round to two decimals
      minTemperature: response.weather.minTemperature,
      maxTemperature: response.weather.maxTemperature,
      airPressure: response.weather.pressure,
      humidity: response.weather.humidity,
      windSpeed: response.wind.speed,
      weatherDescription: response.weatherDescriptions.isNotEmpty
          ? response.weatherDescriptions[0].description
          : "",
      weatherIcon: icon,
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
      ];
}
