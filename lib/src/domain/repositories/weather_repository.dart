import 'package:breeze/core/resources/data_state.dart';
import 'package:breeze/src/domain/models/daily_forecast.dart';

abstract class WeatherRepository {
  Future<DataState<DailyForecast>> getDailyForecastByCoordinates(
      String latitude, String longitude, String unitSystem);

  Future<DataState<DailyForecast>> getDailyForecastByCityName(
      String cityName, String unitSystem);
}
