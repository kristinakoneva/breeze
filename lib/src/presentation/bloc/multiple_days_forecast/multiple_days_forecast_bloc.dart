import 'package:breeze/core/states/data_state.dart';
import 'package:breeze/src/domain/use_cases/get_multiple_days_forecast_by_city_name.dart';
import 'package:breeze/src/presentation/bloc/multiple_days_forecast/multiple_days_forecast_event.dart';
import 'package:breeze/src/presentation/bloc/multiple_days_forecast/multiple_days_forecast_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultipleDaysForecastBloc
    extends Bloc<MultipleDaysForecastEvent, MultipleDaysForecastState> {
  final GetMultipleDaysForecastByCityNameUseCase
      _getMultipleDaysForecastByCityNameUseCase;

  MultipleDaysForecastBloc(this._getMultipleDaysForecastByCityNameUseCase)
      : super(const MultipleDaysForecastLoading()) {
    on<GetMultipleDaysForecastByCityName>(onGetMultipleDaysForecastByCityName);
  }

  void onGetMultipleDaysForecastByCityName(
      GetMultipleDaysForecastByCityName event,
      Emitter<MultipleDaysForecastState> emit) async {
    emit(const MultipleDaysForecastLoading());
    final dataState = await _getMultipleDaysForecastByCityNameUseCase(
        params: event.cityNameParams!);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(MultipleDaysForecastSuccess(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(MultipleDaysForecastError(dataState.error!));
    }
  }
}
