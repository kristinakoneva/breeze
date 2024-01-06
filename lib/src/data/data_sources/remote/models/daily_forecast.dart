class DailyForecastResponse {
  Coordinates coordinates;
  List<WeatherDescription> weatherDescriptions;
  Weather weather;
  Wind wind;
  String cityName;

  DailyForecastResponse({
    required this.coordinates,
    required this.weatherDescriptions,
    required this.weather,
    required this.wind,
    required this.cityName,
  });

  factory DailyForecastResponse.fromJson(Map<String, dynamic> map) {
    return DailyForecastResponse(
      coordinates: Coordinates(
        latitude: map['coord']['lat'] ?? 0.0,
        longitude: map['coord']['lon'] ?? 0.0,
      ),
      weatherDescriptions: (map['weather'] as List<dynamic>?)
              ?.map((item) => WeatherDescription(
                    description: item['main'] ?? "",
                    icon: item['icon'] ?? "",
                  ))
              ?.toList() ??
          [],
      weather: Weather(
        currentTemperature: map['main']['temp'] ?? 0.0,
        minTemperature: map['main']['temp_min'] ?? 0.0,
        maxTemperature: map['main']['temp_max'] ?? 0.0,
        humidity: map['main']['humidity'] ?? 0,
        pressure: map['main']['pressure'] ?? 0,
      ),
      wind: Wind(speed: map['wind']['speed'] ?? 0.0),
      cityName: map['name'] ?? "",
    );
  }
}

class Coordinates {
  double latitude;
  double longitude;

  Coordinates({required this.latitude, required this.longitude});
}

class WeatherDescription {
  String description;
  String icon;

  WeatherDescription({required this.description, required this.icon});
}

class Weather {
  double currentTemperature;
  double minTemperature;
  double maxTemperature;
  int humidity;
  int pressure;

  Weather({
    required this.currentTemperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.pressure,
  });
}

class Wind {
  double speed;

  Wind({required this.speed});
}
