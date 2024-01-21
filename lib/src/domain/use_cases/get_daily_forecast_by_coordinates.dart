import 'package:breeze/core/states/data_state.dart';
import 'package:breeze/core/use_case/use_case.dart';
import 'package:breeze/src/domain/models/daily_forecast.dart';
import 'package:breeze/src/domain/models/forecast_by_coordinates_params.dart';
import 'package:breeze/src/domain/repositories/weather_repository.dart';

class GetDailyForecastByCoordinatesUseCase
    implements UseCase<DataState<DailyForecast>, ForecastByCoordinatesParams> {
  final WeatherRepository _weatherRepository;

  GetDailyForecastByCoordinatesUseCase(this._weatherRepository);

  @override
  Future<DataState<DailyForecast>> call(
      {required ForecastByCoordinatesParams params}) {
    return _weatherRepository.getDailyForecastByCoordinates(
      params.latitude,
      params.longitude,
    );
  }
}
