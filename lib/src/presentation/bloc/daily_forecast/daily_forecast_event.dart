import 'package:breeze/src/domain/models/forecast_by_city_name_params.dart';
import 'package:breeze/src/domain/models/forecast_by_coordinates_params.dart';
import 'package:equatable/equatable.dart';

/// Abstract base class for daily forecast events.
abstract class DailyForecastEvent extends Equatable {
  final ForecastByCityNameParams? cityNameParams;
  final ForecastByCoordinatesParams? coordinatesParams;

  /// Creates a new instance of [DailyForecastEvent].
  const DailyForecastEvent({this.cityNameParams, this.coordinatesParams});

  @override
  List<Object?> get props => [cityNameParams, coordinatesParams];
}

/// Event to trigger fetching daily forecast by coordinates.
class GetDailyForecastByCoordinates extends DailyForecastEvent {
  /// Creates a new instance of [GetDailyForecastByCoordinates].
  ///
  /// Requires [coordinatesParams] for fetching the forecast.
  const GetDailyForecastByCoordinates(coordinatesParams)
      : super(coordinatesParams: coordinatesParams);
}

/// Event to trigger fetching daily forecast by city name.
class GetDailyForecastByCityName extends DailyForecastEvent {
  /// Creates a new instance of [GetDailyForecastByCityName].
  ///
  /// Requires [cityNameParams] for fetching the forecast.
  const GetDailyForecastByCityName(cityNameParams)
      : super(cityNameParams: cityNameParams);
}
