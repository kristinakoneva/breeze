import 'package:breeze/core/resources/data_state.dart';
import 'package:breeze/src/data/data_sources/remote/api_key.dart';
import 'package:breeze/src/data/data_sources/remote/weather_api_service.dart';
import 'package:breeze/src/domain/models/daily_forecast.dart';
import 'package:breeze/src/domain/repositories/weather_repository.dart';
import 'dart:io';

import 'package:dio/dio.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService _weatherApiService;

  WeatherRepositoryImpl(this._weatherApiService);

  @override
  Future<DataState<DailyForecast>> getDailyForecastByCityName(
      String cityName, String unitSystem) async {
    try {
      final httpResponse = await _weatherApiService.getDailyForecastByCityName(
          cityName: cityName, unitSystem: unitSystem, apiKey: apiKey);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(
            DailyForecast.fromDailyForecastResponse(httpResponse.data));
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
  Future<DataState<DailyForecast>> getDailyForecastByCoordinates(
      String latitude, String longitude, String unitSystem) async {
    try {
      final httpResponse =
          await _weatherApiService.getDailyForecastByCoordinates(
              latitude: latitude,
              longitude: longitude,
              unitSystem: unitSystem,
              apiKey: apiKey);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(
            DailyForecast.fromDailyForecastResponse(httpResponse.data));
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
