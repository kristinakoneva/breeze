import 'package:breeze/core/resources/data_state.dart';
import 'package:breeze/src/domain/use_cases/get_daily_forecast_by_city_name.dart';
import 'package:breeze/src/domain/use_cases/get_daily_forecast_by_coordinates.dart';
import 'package:breeze/src/presentation/bloc/daily_forecast/daily_forecast_event.dart';
import 'package:breeze/src/presentation/bloc/daily_forecast/daily_forecast_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyForecastBloc extends Bloc<DailyForecastEvent, DailyForecastState> {
  final GetDailyForecastByCoordinatesUseCase
      _getDailyForecastByCoordinatesUseCase;
  final GetDailyForecastByCityNameUseCase _getDailyForecastByCityNameUseCase;

  DailyForecastBloc(
    this._getDailyForecastByCoordinatesUseCase,
    this._getDailyForecastByCityNameUseCase,
  ) : super(const DailyForecastLoading()) {
    on<GetDailyForecastByCoordinates>(onGetDailyForecastByCoordinates);
    on<GetDailyForecastByCityName>(onGetDailyForecastByCityName);
  }

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