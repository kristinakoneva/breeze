import 'package:breeze/core/states/data_state.dart';
import 'package:breeze/core/use_case/use_case.dart';
import 'package:breeze/src/domain/models/forecast_by_city_name_params.dart';
import 'package:breeze/src/domain/models/multiple_days_forecast.dart';
import 'package:breeze/src/domain/repositories/weather_repository.dart';

/// Use case implementation for fetching the multiple days forecast by city name.
class GetMultipleDaysForecastByCityNameUseCase
    implements
        UseCase<DataState<MultipleDaysForecast>, ForecastByCityNameParams> {
  final WeatherRepository _weatherRepository;

  /// Creates a new instance of [GetMultipleDaysForecastByCityNameUseCase].
  ///
  /// Requires a [WeatherRepository] instance to interact with the data layer.
  GetMultipleDaysForecastByCityNameUseCase(this._weatherRepository);

  @override
  Future<DataState<MultipleDaysForecast>> call({
    required ForecastByCityNameParams params,
  }) {
    return _weatherRepository.getMultipleDaysForecastByCityName(
      params.cityName,
    );
  }
}
