import 'package:breeze/src/domain/models/daily_forecast.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class DailyForecastState extends Equatable {
  final DailyForecast? dailyForecast;
  final DioError? error;

  @override
  List<Object?> get props => [dailyForecast, error];

  const DailyForecastState({this.dailyForecast, this.error});
}

class DailyForecastLoading extends DailyForecastState {
  const DailyForecastLoading();
}

class DailyForecastDone extends DailyForecastState {
  const DailyForecastDone(DailyForecast dailyForecast)
      : super(dailyForecast: dailyForecast);
}

class DailyForecastError extends DailyForecastState {
  const DailyForecastError(DioError error) : super(error: error);
}
