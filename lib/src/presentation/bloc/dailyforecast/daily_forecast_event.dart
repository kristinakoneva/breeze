import 'package:breeze/src/domain/models/forecast_by_city_name_params.dart';
import 'package:breeze/src/domain/models/forecast_by_coordinates_params.dart';
import 'package:equatable/equatable.dart';

abstract class DailyForecastEvent extends Equatable {
  final ForecastByCityNameParams? cityNameParams;
  final ForecastByCoordinatesParams? coordinatesParams;

  const DailyForecastEvent({this.cityNameParams, this.coordinatesParams});

  @override
  List<Object?> get props => [cityNameParams, coordinatesParams];
}

class GetDailyForecastByCoordinates extends DailyForecastEvent {
  const GetDailyForecastByCoordinates(coordinatesParams)
      : super(coordinatesParams: coordinatesParams);
}

class GetDailyForecastByCityName extends DailyForecastEvent {
  const GetDailyForecastByCityName(cityNameParams)
      : super(cityNameParams: cityNameParams);
}
