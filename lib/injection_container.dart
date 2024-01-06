import 'package:breeze/src/data/data_sources/remote/weather_api_service.dart';
import 'package:breeze/src/domain/repositories/weather_repository.dart';
import 'package:breeze/src/domain/repositories/weather_repository_impl.dart';
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
}
