import 'package:breeze/src/domain/models/forecast_by_city_name_params.dart';
import 'package:equatable/equatable.dart';

/// Abstract base class for multiple days forecast events.
abstract class MultipleDaysForecastEvent extends Equatable {
  final ForecastByCityNameParams? cityNameParams;

  /// Creates a new instance of [MultipleDaysForecastEvent].
  const MultipleDaysForecastEvent({this.cityNameParams});

  @override
  List<Object?> get props => [cityNameParams];
}

/// Event to trigger fetching multiple days forecast by city name.
class GetMultipleDaysForecastByCityName extends MultipleDaysForecastEvent {
  /// Creates a new instance of [GetMultipleDaysForecastByCityName].
  ///
  /// Requires [cityNameParams] for fetching the forecast.
  const GetMultipleDaysForecastByCityName(cityNameParams)
      : super(cityNameParams: cityNameParams);
}
