/// Represents the parameters required for fetching a weather forecast by city name.
class ForecastByCityNameParams {
  /// The name of the city for which the forecast is requested.
  final String cityName;

  /// Creates a new instance of [ForecastByCityNameParams].
  ///
  /// Requires the [cityName] parameter representing the name of the city.
  const ForecastByCityNameParams({required this.cityName});
}
