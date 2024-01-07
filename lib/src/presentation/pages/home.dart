import 'package:breeze/config/theme/colors.dart';
import 'package:breeze/src/domain/models/daily_forecast.dart';
import 'package:breeze/src/domain/models/forecast_by_city_name_params.dart';
import 'package:breeze/src/domain/usecases/get_daily_forecast_by_city_name.dart';
import 'package:breeze/src/presentation/bloc/dailyforecast/daily_forecast_bloc.dart';
import 'package:breeze/src/presentation/bloc/dailyforecast/daily_forecast_event.dart';
import 'package:breeze/src/presentation/bloc/dailyforecast/daily_forecast_state.dart';
import 'package:breeze/src/presentation/bloc/multiple_days_forecast/multiple_days_forecast_bloc.dart';
import 'package:breeze/src/presentation/bloc/multiple_days_forecast/multiple_days_forecast_event.dart';
import 'package:breeze/src/presentation/bloc/multiple_days_forecast/multiple_days_forecast_state.dart';
import 'package:breeze/src/presentation/widgets/current_weather.dart';
import 'package:breeze/src/presentation/widgets/weather_info.dart';
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
    DailyForecastBloc dailyForecastBloc =
        BlocProvider.of<DailyForecastBloc>(context);
    dailyForecastBloc.add(GetDailyForecastByCityName(
        ForecastByCityNameParams(cityName: "London")));
    return Scaffold(body: _buildBody(dailyForecastBloc));
  }

  _buildBody(DailyForecastBloc dailyForecastBloc) {
    return BlocBuilder<DailyForecastBloc, DailyForecastState>(
      builder: (context, state) {
        if (state is DailyForecastLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else if (state is DailyForecastSuccess) {
          return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                child: Column(
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: SearchBar(
                            constraints: const BoxConstraints(
                              minHeight: 30,
                            ),
                            shape: MaterialStateProperty.all(
                                const ContinuousRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            )),
                            leading: const Icon(
                              Icons.search,
                              color: colorSurface,
                            ),
                            hintText: 'Search',
                            onSubmitted: (String value) {
                              if (value.isNotEmpty) {
                                dailyForecastBloc.add(
                                    GetDailyForecastByCityName(
                                        ForecastByCityNameParams(
                                            cityName: value)));
                              }
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // TODO: Implement settings
                          },
                          icon: const Icon(Icons.menu),
                        )
                      ],
                    ),
                    CurrentWeatherWidget(
                      dailyForecast: state.dailyForecast!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement next 3 days forecast
                      },
                      child: const Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("NEXT 3 DAYS"),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      childAspectRatio: 1.4,
                      children:
                          _getListOfWeatherInfoWidgets(state.dailyForecast!),
                    ),
                    _testMultipleDaysForecast(),
                  ],
                ),
              ));
        } else if (state is DailyForecastError) {
          return const Center(
            child: Text("Error"),
          );
        } else {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }

  _getListOfWeatherInfoWidgets(DailyForecast dailyForecast) {
    return [
      WeatherInfoWidget(
        label: "TEMPERATURE",
        value:
            "${dailyForecast.minTemperature}/${dailyForecast.maxTemperature} °C",
      ),
      WeatherInfoWidget(
        label: "WIND SPEED",
        value: "${dailyForecast.windSpeed} m/s",
      ),
      WeatherInfoWidget(
        label: "HUMIDITY",
        value: "${dailyForecast.humidity} %",
      ),
      WeatherInfoWidget(
        label: "AIR PRESSURE",
        value: "${dailyForecast.airPressure} hPa",
      ),
    ];
  }

  _testMultipleDaysForecast() {
    return BlocBuilder<MultipleDaysForecastBloc, MultipleDaysForecastState>(
        builder: (context, state) {
      if (state is MultipleDaysForecastLoading) {
        return TextButton(
            onPressed: () {
              BlocProvider.of<MultipleDaysForecastBloc>(context).add(
                  GetMultipleDaysForecastByCityName(
                      ForecastByCityNameParams(cityName: "London")));
            },
            child: const Text("Loading + trigger..."));
      } else if (state is MultipleDaysForecastSuccess) {
        print("CHECK: ${state.multipleDaysForecast}");
        return const Text("Success");
      } else if (state is MultipleDaysForecastError) {
        return const Text("Error");
      } else {
        return const Text("Something went wrong");
      }
    });
  }
}
