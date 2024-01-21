import 'package:breeze/core/states/data_state.dart';
import 'package:breeze/src/domain/use_cases/get_daily_forecast_by_city_name.dart';
import 'package:breeze/src/domain/use_cases/get_daily_forecast_by_coordinates.dart';
import 'package:breeze/src/presentation/bloc/daily_forecast/daily_forecast_event.dart';
import 'package:breeze/src/presentation/bloc/daily_forecast/daily_forecast_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// BLoC class responsible for managing the state of daily weather forecasts.
class DailyForecastBloc extends Bloc<DailyForecastEvent, DailyForecastState> {
  final GetDailyForecastByCoordinatesUseCase
      _getDailyForecastByCoordinatesUseCase;
  final GetDailyForecastByCityNameUseCase _getDailyForecastByCityNameUseCase;

  /// Creates a new instance of [DailyForecastBloc].
  ///
  /// Requires instances of [GetDailyForecastByCoordinatesUseCase] and [GetDailyForecastByCityNameUseCase].
  DailyForecastBloc(
    this._getDailyForecastByCoordinatesUseCase,
    this._getDailyForecastByCityNameUseCase,
  ) : super(const DailyForecastLoading()) {
    on<GetDailyForecastByCoordinates>(onGetDailyForecastByCoordinates);
    on<GetDailyForecastByCityName>(onGetDailyForecastByCityName);
  }

  /// Event handler for fetching daily forecast by coordinates.
  void onGetDailyForecastByCoordinates(GetDailyForecastByCoordinates event,
      Emitter<DailyForecastState> emit) async {
    emit(const DailyForecastLoading());
    final dataState = await _getDailyForecastByCoordinatesUseCase(
        params: event.coordinatesParams!);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(DailyForecastSuccess(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(DailyForecastError(dataState.error!));
    }
  }

  /// Event handler for fetching daily forecast by city name.
  void onGetDailyForecastByCityName(GetDailyForecastByCityName event,
      Emitter<DailyForecastState> emit) async {
    emit(const DailyForecastLoading());
    final dataState =
        await _getDailyForecastByCityNameUseCase(params: event.cityNameParams!);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(DailyForecastSuccess(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(DailyForecastError(dataState.error!));
    }
  }
}
