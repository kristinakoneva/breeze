import 'package:breeze/core/constants/constants.dart';
import 'package:breeze/src/data/data_sources/remote/models/multiple_days_forecast.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'api_key.dart';
import 'models/daily_forecast.dart';

part 'weather_api_service.g.dart';

@RestApi(baseUrl: weatherApiBaseUrl)
abstract class WeatherApiService {
  factory WeatherApiService(Dio dio) = _WeatherApiService;

  @GET("weather")
  Future<HttpResponse<DailyForecastResponse>> getDailyForecastByCoordinates({
    @Query("lat") required String latitude,
    @Query("lon") required String longitude,
    @Query("units") required String unitSystem,
    @Query("appid") String apiKey = apiKey,
  });

  @GET("weather")
  Future<HttpResponse<DailyForecastResponse>> getDailyForecastByCityName({
    @Query("q") required String cityName,
    @Query("units") required String unitSystem,
    @Query("appid") String apiKey = apiKey,
  });

  @GET("forecast")
  Future<HttpResponse<MultipleDaysForecastResponse>>
      getMultipleDaysForecastByCityName({
    @Query("q") required String cityName,
    @Query("units") required String unitSystem,
    @Query("appid") String apiKey = apiKey,
  });
}
