import 'package:breeze/src/domain/models/multiple_days_forecast.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

/// Abstract base class for multiple days forecast states.
abstract class MultipleDaysForecastState extends Equatable {
  final MultipleDaysForecast? multipleDaysForecast;
  final DioError? error;

  @override
  List<Object?> get props => [multipleDaysForecast, error];

  /// Creates a new instance of [MultipleDaysForecastState].
  const MultipleDaysForecastState({this.multipleDaysForecast, this.error});
}

/// State indicating that multiple days forecast data is loading.
class MultipleDaysForecastLoading extends MultipleDaysForecastState {
  /// Creates a new instance of [MultipleDaysForecastLoading].
  const MultipleDaysForecastLoading();
}

/// State indicating that multiple days forecast data was successfully retrieved.
class MultipleDaysForecastSuccess extends MultipleDaysForecastState {
  /// Creates a new instance of [MultipleDaysForecastSuccess].
  ///
  /// Requires [multipleDaysForecast] for the successful data.
  const MultipleDaysForecastSuccess(MultipleDaysForecast dailyForecast)
      : super(multipleDaysForecast: dailyForecast);
}

/// State indicating that an error occurred while fetching multiple days forecast data.
class MultipleDaysForecastError extends MultipleDaysForecastState {
  /// Creates a new instance of [MultipleDaysForecastError].
  ///
  /// Requires [error] containing details of the error.
  const MultipleDaysForecastError(DioError error) : super(error: error);
}
