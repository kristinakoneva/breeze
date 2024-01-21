import 'package:breeze/src/domain/models/forecast_by_city_name_params.dart';
import 'package:breeze/src/domain/models/multiple_days_forecast.dart';
import 'package:breeze/src/presentation/bloc/multiple_days_forecast/multiple_days_forecast_bloc.dart';
import 'package:breeze/src/presentation/bloc/multiple_days_forecast/multiple_days_forecast_event.dart';
import 'package:breeze/src/presentation/bloc/multiple_days_forecast/multiple_days_forecast_state.dart';
import 'package:breeze/src/presentation/widgets/forecast_per_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultipleDaysForecastPage extends StatefulWidget {
  final String cityName;

  const MultipleDaysForecastPage({Key? key, required this.cityName})
      : super(key: key);

  @override
  State<MultipleDaysForecastPage> createState() =>
      _MultipleDaysForecastPageState();
}

class _MultipleDaysForecastPageState extends State<MultipleDaysForecastPage> {
  @override
  Widget build(BuildContext context) {
    MultipleDaysForecastBloc multipleDaysForecastBloc =
        BlocProvider.of<MultipleDaysForecastBloc>(context)
          ..add(GetMultipleDaysForecastByCityName(
              ForecastByCityNameParams(cityName: widget.cityName)));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 32,
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
        title: Text("NEXT 3 DAYS IN ${widget.cityName.toUpperCase()}"),
      ),
      body: _buildBody(multipleDaysForecastBloc),
    );
  }

  _buildBody(MultipleDaysForecastBloc multipleDaysForecastBloc) {
    return BlocBuilder<MultipleDaysForecastBloc, MultipleDaysForecastState>(
        builder: (context, state) {
      if (state is MultipleDaysForecastLoading) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      } else if (state is MultipleDaysForecastSuccess) {
        return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _getListItems(
                      state.multipleDaysForecast!.forecasts)[index];
                },
              ),
            ));
      } else if (state is MultipleDaysForecastError) {
        return const Center(
          child: Text("Error"),
        );
      } else {
        return const Center(
          child: Text("Something went wrong"),
        );
      }
    });
  }

  /// Builds a list of forecast items based on the provided list of [forecasts].
  _getListItems(List<ForecastPerDay> forecasts) {
    return [
      ForecastPerDayWidget(
        forecast: forecasts[0],
        dayLabel: "TOMORROW",
      ),
      ForecastPerDayWidget(
        forecast: forecasts[1],
        dayLabel: _getDayOfWeek(forecasts[1].date),
      ),
      ForecastPerDayWidget(
        forecast: forecasts[2],
        dayLabel: _getDayOfWeek(forecasts[2].date),
      ),
    ];
  }

  /// Returns the day of the week as a string for the provided date.
  _getDayOfWeek(DateTime date) {
    switch (date.weekday) {
      case 1:
        return "MONDAY";
      case 2:
        return "TUESDAY";
      case 3:
        return "WEDNESDAY";
      case 4:
        return "THURSDAY";
      case 5:
        return "FRIDAY";
      case 6:
        return "SATURDAY";
      case 7:
        return "SUNDAY";
      default:
        return "";
    }
  }
}
