import 'package:breeze/core/resources/data_state.dart';
import 'package:breeze/src/data/local/shared_preferences.dart';
import 'package:breeze/src/data/remote/api_key.dart';
import 'package:breeze/src/data/remote/weather_api_service.dart';
import 'package:breeze/src/domain/models/daily_forecast.dart';
import 'package:breeze/src/domain/models/multiple_days_forecast.dart';
import 'package:breeze/src/domain/repositories/weather_repository.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService _weatherApiService;

  WeatherRepositoryImpl(this._weatherApiService);

  @override
  Future<DataState<DailyForecast>> getDailyForecastByCoordinates(
    String latitude,
    String longitude,
  ) async {
    try {
      final unitSystem = await getUnitSystem();

      final httpResponse =
          await _weatherApiService.getDailyForecastByCoordinates(
              latitude: latitude,
              longitude: longitude,
              unitSystem: unitSystem,
              apiKey: apiKey);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(DailyForecast.fromDailyForecastResponse(
            httpResponse.data, unitSystem));
      } else {
        return DataFailed(DioError(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioErrorType.response,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DailyForecast>> getDailyForecastByCityName(
    String cityName,
  ) async {
    try {
      final unitSystem = await getUnitSystem();

      final httpResponse = await _weatherApiService.getDailyForecastByCityName(
          cityName: cityName, unitSystem: unitSystem, apiKey: apiKey);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(DailyForecast.fromDailyForecastResponse(
            httpResponse.data, unitSystem));
      } else {
        return DataFailed(DioError(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioErrorType.response,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<MultipleDaysForecast>> getMultipleDaysForecastByCityName(
    String cityName,
  ) async {
    try {
      final unitSystem = await getUnitSystem();

      final httpResponse =
          await _weatherApiService.getMultipleDaysForecastByCityName(
              cityName: cityName, unitSystem: unitSystem, apiKey: apiKey);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(
            MultipleDaysForecast.fromMultipleDaysForecastResponse(
          httpResponse.data,
          unitSystem,
        ));
      } else {
        return DataFailed(DioError(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioErrorType.response,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
