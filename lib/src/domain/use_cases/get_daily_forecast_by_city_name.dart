import 'package:breeze/core/states/data_state.dart';
import 'package:breeze/core/use_case/use_case.dart';
import 'package:breeze/src/domain/models/daily_forecast.dart';
import 'package:breeze/src/domain/models/forecast_by_city_name_params.dart';
import 'package:breeze/src/domain/repositories/weather_repository.dart';

/// Use case implementation for fetching the daily forecast by city name.
class GetDailyForecastByCityNameUseCase
    implements UseCase<DataState<DailyForecast>, ForecastByCityNameParams> {
  final WeatherRepository _weatherRepository;

  /// Creates a new instance of [GetDailyForecastByCityNameUseCase].
  ///
  /// Requires a [WeatherRepository] instance to interact with the data layer.
  GetDailyForecastByCityNameUseCase(this._weatherRepository);

  @override
  Future<DataState<DailyForecast>> call({
    required ForecastByCityNameParams params,
  }) {
    return _weatherRepository.getDailyForecastByCityName(
      params.cityName,
    );
  }
}
