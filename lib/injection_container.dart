import 'package:breeze/src/data/data_sources/remote/weather_api_service.dart';
import 'package:breeze/src/domain/repositories/weather_repository.dart';
import 'package:breeze/src/domain/repositories/weather_repository_impl.dart';
import 'package:breeze/src/domain/usecases/get_daily_forecast_by_city_name.dart';
import 'package:breeze/src/domain/usecases/get_daily_forecast_by_coordinates.dart';
import 'package:breeze/src/presentation/bloc/dailyforecast/daily_forecast_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  serviceLocator.registerSingleton<Dio>(Dio());

  // Dependencies
  serviceLocator.registerSingleton<WeatherApiService>(
      WeatherApiService(serviceLocator()));

  serviceLocator.registerSingleton<WeatherRepository>(
      WeatherRepositoryImpl(serviceLocator()));

  //UseCases
  serviceLocator.registerSingleton<GetDailyForecastByCoordinatesUseCase>(
      GetDailyForecastByCoordinatesUseCase(serviceLocator()));

  serviceLocator.registerSingleton<GetDailyForecastByCityNameUseCase>(
      GetDailyForecastByCityNameUseCase(serviceLocator()));

  //Blocs
  serviceLocator.registerFactory<DailyForecastBloc>(
      () => DailyForecastBloc(serviceLocator(), serviceLocator()));
}
