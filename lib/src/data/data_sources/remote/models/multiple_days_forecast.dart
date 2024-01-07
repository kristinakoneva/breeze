class MultipleDaysForecastResponse {
  final List<Forecast> forecastsList;

  MultipleDaysForecastResponse({required this.forecastsList});

  factory MultipleDaysForecastResponse.fromJson(Map<String, dynamic> map) {
    return MultipleDaysForecastResponse(
      forecastsList: (map['list'] as List<dynamic>?)
              ?.map((item) => Forecast.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class Forecast {
  final Weather weather;
  final List<WeatherDescription>? weatherDescriptions;
  final Wind wind;
  final String date;

  Forecast({
    required this.weather,
    this.weatherDescriptions,
    required this.wind,
    required this.date,
  });

  factory Forecast.fromJson(Map<String, dynamic> map) {
    return Forecast(
      weather: Weather.fromJson(map['main']),
      weatherDescriptions: (map['weather'] as List<dynamic>?)
          ?.map((item) => WeatherDescription.fromJson(item))
          ?.toList(),
      wind: Wind.fromJson(map['wind']),
      date: map['dt_txt'] ?? "",
    );
  }
}

class Weather {
  final double currentTemperature;
  final double minTemperature;
  final double maxTemperature;
  final int humidity;
  final int pressure;

  Weather({
    required this.currentTemperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.pressure,
  });

  factory Weather.fromJson(Map<String, dynamic> map) {
    return Weather(
      currentTemperature: (map['temp'] as num).toDouble(),
      minTemperature: (map['temp_min'] as num).toDouble(),
      maxTemperature: (map['temp_max'] as num).toDouble(),
      humidity: map['humidity'] ?? 0,
      pressure: map['pressure'] ?? 0,
    );
  }
}

class Wind {
  final double speed;

  Wind({required this.speed});

  factory Wind.fromJson(Map<String, dynamic> map) {
    return Wind(
      speed: (map['speed'] as num).toDouble(),
    );
  }
}

class WeatherDescription {
  final String description;
  final String icon;

  WeatherDescription({
    required this.description,
    required this.icon,
  });

  factory WeatherDescription.fromJson(Map<String, dynamic> map) {
    return WeatherDescription(
      description: map['main'] ?? "",
      icon: map['icon'] ?? "",
    );
  }
}
