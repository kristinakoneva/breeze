/// Represents the response for the daily weather forecast.
class DailyForecastResponse {
  String cityName;
  double currentTemperature;
  double minTemperature;
  double maxTemperature;
  int humidity;
  int pressure;
  double windSpeed;
  String weatherDescription;
  String iconCode;
  double latitude;
  double longitude;

  DailyForecastResponse({
    required this.cityName,
    required this.currentTemperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.weatherDescription,
    required this.iconCode,
    required this.latitude,
    required this.longitude,
  });

  /// Parses the JSON response from the API.
  factory DailyForecastResponse.fromJson(Map<String, dynamic> map) {
    return DailyForecastResponse(
      latitude: (map['coord']['lat'] as num).toDouble(),
      longitude: (map['coord']['lon'] as num).toDouble(),
      weatherDescription: (map['weather'] as List<dynamic>?)
              ?.map((item) => item['main'] ?? "")
              .toList()[0] ??
          "",
      iconCode: (map['weather'] as List<dynamic>?)
              ?.map(
                (item) => item['icon'] ?? "",
              )
              .toList()[0] ??
          "",
      currentTemperature: (map['main']['temp'] as num).toDouble(),
      minTemperature: (map['main']['temp_min'] as num).toDouble(),
      maxTemperature: (map['main']['temp_max'] as num).toDouble(),
      humidity: map['main']['humidity'] ?? 0,
      pressure: map['main']['pressure'] ?? 0,
      windSpeed: (map['wind']['speed'] as num).toDouble(),
      cityName: map['name'] ?? "",
    );
  }
}
