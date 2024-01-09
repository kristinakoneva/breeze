import 'package:breeze/core/resources/data_state.dart';
import 'package:breeze/core/usecase/usecase.dart';
import 'package:breeze/src/domain/models/forecast_by_city_name_params.dart';
import 'package:breeze/src/domain/models/multiple_days_forecast.dart';
import 'package:breeze/src/domain/repositories/weather_repository.dart';

class GetMultipleDaysForecastByCityNameUseCase
    implements
        UseCase<DataState<MultipleDaysForecast>, ForecastByCityNameParams> {
  final WeatherRepository _weatherRepository;

  GetMultipleDaysForecastByCityNameUseCase(this._weatherRepository);

  @override
  Future<DataState<MultipleDaysForecast>> call(
      {required ForecastByCityNameParams params}) {
    return _weatherRepository.getMultipleDaysForecastByCityName(
      params.cityName,
    );
  }
}
