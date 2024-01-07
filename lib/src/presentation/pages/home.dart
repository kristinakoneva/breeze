import 'package:breeze/injection_container.dart';
import 'package:breeze/src/domain/models/forecast_by_city_name_params.dart';
import 'package:breeze/src/presentation/bloc/dailyforecast/daily_forecast_bloc.dart';
import 'package:breeze/src/presentation/bloc/dailyforecast/daily_forecast_event.dart';
import 'package:breeze/src/presentation/bloc/dailyforecast/daily_forecast_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Breeze"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<DailyForecastBloc, DailyForecastState>(
              builder: (context, state) {
                if (state is DailyForecastLoading) {
                  print("TEMPPP loading");
                  return const Text("loading");
                }
                if (state is DailyForecastError) {
                  print("TEMPPP error");
                  return const Text("error");
                }
                if (state is DailyForecastDone) {
                  print("TEMPPP temperatura dize se bura");

                  return Text(state.dailyForecast!.minTemperature.toString());
                }
                return const Text("empty");
              },
            ),
            _buildBodyWidget(),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<DailyForecastBloc>(context).add(
                  GetDailyForecastByCityName(
                    ForecastByCityNameParams(cityName: "Bitola"),
                  ),
                );
              },
              child: const Text("lala"),
            ),
          ],
        ),
      ),
    );
  }

  _buildBodyWidget() {
    return BlocBuilder<DailyForecastBloc, DailyForecastState>(
      builder: (_, state) {
        if (state is DailyForecastLoading) {
          print("TEMPPP loading");
          return const Text("loading");
        }
        if (state is DailyForecastError) {
          print("TEMPPP error");
          return const Text("error");
        }
        if (state is DailyForecastDone) {
          print("TEMPPP temperatura dize se bura");

          return Text(state.dailyForecast!.minTemperature.toString());
        }
        return const Text("empty");
      },
    );
  }
}
