import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'api_key.dart';
import 'models/daily_forecast.dart';

part 'weather_api_service.g.dart';

@RestApi(baseUrl: weatherApiBaseUrl)
abstract class WeatherApiService {
  factory WeatherApiService(Dio dio) = _WeatherApiService;

  @GET("weather")
  Future<HttpResponse<DailyForecastResponse>> getDailyForecastByCoordinates({
    @Query("lat") String latitude,
    @Query("lon") String longitude,
    @Query("units") String unitSystem,
    @Query("appid") String apiKey = apiKey,
  });

  @GET("weather")
  Future<HttpResponse<DailyForecastResponse>> getDailyForecastByCityName({
    @Query("q") String cityName,
    @Query("units") String unitSystem,
    @Query("appid") String apiKey = apiKey,
  });
}
