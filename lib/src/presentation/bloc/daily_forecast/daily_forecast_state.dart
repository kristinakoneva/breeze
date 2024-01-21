import 'package:breeze/src/domain/models/daily_forecast.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

/// Abstract base class for daily forecast states.
abstract class DailyForecastState extends Equatable {
  final DailyForecast? dailyForecast;
  final DioError? error;

  /// Creates a new instance of [DailyForecastState].
  const DailyForecastState({this.dailyForecast, this.error});

  @override
  List<Object?> get props => [dailyForecast, error];
}

/// State indicating that the daily forecast is loading.
class DailyForecastLoading extends DailyForecastState {
  const DailyForecastLoading();
}

/// State indicating a successful fetch of the daily forecast.
class DailyForecastSuccess extends DailyForecastState {
  /// Creates a new instance of [DailyForecastSuccess].
  ///
  /// Requires [dailyForecast] for a successful forecast.
  const DailyForecastSuccess(DailyForecast dailyForecast)
      : super(dailyForecast: dailyForecast);
}

/// State indicating an error during the fetch of the daily forecast.
class DailyForecastError extends DailyForecastState {
  /// Creates a new instance of [DailyForecastError].
  ///
  /// Requires [error] for details of the encountered error.
  const DailyForecastError(DioError error) : super(error: error);
}
