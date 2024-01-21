import 'package:breeze/core/states/data_state.dart';
import 'package:breeze/src/domain/models/daily_forecast.dart';
import 'package:breeze/src/domain/models/multiple_days_forecast.dart';

abstract class WeatherRepository {
  Future<DataState<DailyForecast>> getDailyForecastByCoordinates(
    String latitude,
    String longitude,
  );

  Future<DataState<DailyForecast>> getDailyForecastByCityName(
    String cityName,
  );

  Future<DataState<MultipleDaysForecast>> getMultipleDaysForecastByCityName(
    String cityName,
  );
}
