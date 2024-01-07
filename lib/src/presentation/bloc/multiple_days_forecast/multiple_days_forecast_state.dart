import 'package:breeze/src/domain/models/multiple_days_forecast.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class MultipleDaysForecastState extends Equatable {
  final MultipleDaysForecast? multipleDaysForecast;
  final DioError? error;

  @override
  List<Object?> get props => [multipleDaysForecast, error];

  const MultipleDaysForecastState({this.multipleDaysForecast, this.error});
}

class MultipleDaysForecastLoading extends MultipleDaysForecastState {
  const MultipleDaysForecastLoading();
}

class MultipleDaysForecastSuccess extends MultipleDaysForecastState {
  const MultipleDaysForecastSuccess(MultipleDaysForecast dailyForecast)
      : super(multipleDaysForecast: dailyForecast);
}

class MultipleDaysForecastError extends MultipleDaysForecastState {
  const MultipleDaysForecastError(DioError error) : super(error: error);
}
