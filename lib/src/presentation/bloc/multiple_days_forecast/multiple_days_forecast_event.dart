import 'package:breeze/src/domain/models/forecast_by_city_name_params.dart';
import 'package:equatable/equatable.dart';

abstract class MultipleDaysForecastEvent extends Equatable {
  final ForecastByCityNameParams? cityNameParams;

  const MultipleDaysForecastEvent({this.cityNameParams});

  @override
  List<Object?> get props => [cityNameParams];
}

class GetMultipleDaysForecastByCityName extends MultipleDaysForecastEvent {
  const GetMultipleDaysForecastByCityName(cityNameParams)
      : super(cityNameParams: cityNameParams);
}
