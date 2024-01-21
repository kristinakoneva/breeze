import 'package:breeze/core/constants/constants.dart';
import 'package:breeze/src/data/remote/models/multiple_days_forecast_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'api_key.dart';
import 'models/daily_forecast_response.dart';

part 'weather_api_service.g.dart';

/// Used to make requests to the weather API.
@RestApi(baseUrl: weatherApiBaseUrl)
abstract class WeatherApiService {
  factory WeatherApiService(Dio dio) = _WeatherApiService;

  /// Fetches the daily weather forecast based on geographical coordinates.
  ///
  /// The [latitude] and [longitude] parameters specify the location for which the
  /// weather forecast is requested. The [unitSystem] parameter determines the
  /// units used in the response (e.g., "metric" for Celsius).
  ///
  /// Optionally, you can provide an [apiKey] to authenticate the request. If no
  /// [apiKey] is provided, a default apiKey will be used.
  ///
  /// Returns a [Future] that completes with an [HttpResponse] containing a
  /// [DailyForecastResponse] representing the weather forecast.
  @GET("weather")
  Future<HttpResponse<DailyForecastResponse>> getDailyForecastByCoordinates({
    @Query("lat") required String latitude,
    @Query("lon") required String longitude,
    @Query("units") required String unitSystem,
    @Query("appid") String apiKey = apiKey,
  });

  /// Fetches the daily weather forecast based on the name of a city.
  ///
  /// The [cityName] parameter specifies the name of the city for which the
  /// weather forecast is requested. The [unitSystem] parameter determines the
  /// units used in the response (e.g., "metric" for Celsius).
  ///
  /// Optionally, you can provide an [apiKey] to authenticate the request. If no
  /// [apiKey] is provided, a default apiKey will be used.
  ///
  /// Returns a [Future] that completes with an [HttpResponse] containing a
  /// [DailyForecastResponse] representing the weather forecast.
  @GET("weather")
  Future<HttpResponse<DailyForecastResponse>> getDailyForecastByCityName({
    @Query("q") required String cityName,
    @Query("units") required String unitSystem,
    @Query("appid") String apiKey = apiKey,
  });

  /// Fetches the multiple days weather forecast based on the name of a city.
  ///
  /// The [cityName] parameter specifies the name of the city for which the
  /// weather forecast is requested. The [unitSystem] parameter determines the
  /// units used in the response (e.g., "metric" for Celsius).
  ///
  /// Optionally, you can provide an [apiKey] to authenticate the request. If no
  /// [apiKey] is provided, a default apiKey will be used.
  ///
  /// Returns a [Future] that completes with an [HttpResponse] containing a
  /// [MultipleDaysForecastResponse] representing the multiple days weather forecast.
  @GET("forecast")
  Future<HttpResponse<MultipleDaysForecastResponse>>
      getMultipleDaysForecastByCityName({
    @Query("q") required String cityName,
    @Query("units") required String unitSystem,
    @Query("appid") String apiKey = apiKey,
  });
}
