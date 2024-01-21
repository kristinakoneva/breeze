/// Represents the response for the multiple days weather forecast.
class MultipleDaysForecastResponse {
  final List<Forecast> forecastsList;

  MultipleDaysForecastResponse({required this.forecastsList});

  /// Parses the JSON response from the API.
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
  final double currentTemperature;
  final double minTemperature;
  final double maxTemperature;
  final int humidity;
  final int pressure;
  double windSpeed;
  String weatherDescription;
  String iconCode;
  final String date;

  Forecast({
    required this.currentTemperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.pressure,
    required this.weatherDescription,
    required this.windSpeed,
    required this.iconCode,
    required this.date,
  });

  factory Forecast.fromJson(Map<String, dynamic> map) {
    return Forecast(
      currentTemperature: (map['main']['temp'] as num).toDouble(),
      minTemperature: (map['main']['temp_min'] as num).toDouble(),
      maxTemperature: (map['main']['temp_max'] as num).toDouble(),
      humidity: map['main']['humidity'] ?? 0,
      pressure: map['main']['pressure'] ?? 0,
      windSpeed: (map['wind']['speed'] as num).toDouble(),
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
      date: map['dt_txt'] ?? "",
    );
  }
}
