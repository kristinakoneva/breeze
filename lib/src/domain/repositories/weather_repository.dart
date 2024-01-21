import 'package:breeze/core/states/data_state.dart';
import 'package:breeze/src/domain/models/daily_forecast.dart';
import 'package:breeze/src/domain/models/multiple_days_forecast.dart';

/// Abstract class representing a weather repository responsible for fetching weather data.
abstract class WeatherRepository {
  /// Fetches the daily weather forecast based on coordinates.
  ///
  /// Parameters:
  /// - [latitude]: The latitude of the location.
  /// - [longitude]: The longitude of the location.
  ///
  /// Returns:
  /// A [Future] containing a [DataState] with the [DailyForecast] data.
  Future<DataState<DailyForecast>> getDailyForecastByCoordinates(
    String latitude,
    String longitude,
  );

  /// Fetches the daily weather forecast based on city name.
  ///
  /// Parameters:
  /// - [cityName]: The name of the city for the forecast.
  ///
  /// Returns:
  /// A [Future] containing a [DataState] with the [DailyForecast] data.
  Future<DataState<DailyForecast>> getDailyForecastByCityName(
    String cityName,
  );

  /// Fetches the multiple days weather forecast based on city name.
  ///
  /// Parameters:
  /// - [cityName]: The name of the city for the forecast.
  ///
  /// Returns:
  /// A [Future] containing a [DataState] with the [MultipleDaysForecast] data.
  Future<DataState<MultipleDaysForecast>> getMultipleDaysForecastByCityName(
    String cityName,
  );
}
