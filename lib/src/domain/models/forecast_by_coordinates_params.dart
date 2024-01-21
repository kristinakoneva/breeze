/// Represents the parameters required for fetching a weather forecast by coordinates.
class ForecastByCoordinatesParams {
  /// The latitude of the location for which the forecast is requested.
  final String latitude;

  /// The longitude of the location for which the forecast is requested.
  final String longitude;

  /// Creates a new instance of [ForecastByCoordinatesParams].
  ///
  /// Requires the [latitude] and [longitude] parameters representing the coordinates.
  const ForecastByCoordinatesParams({
    required this.latitude,
    required this.longitude,
  });
}
