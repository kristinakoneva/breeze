import 'package:breeze/config/theme/colors.dart';
import 'package:breeze/core/constants/constants.dart';
import 'package:breeze/src/domain/models/daily_forecast.dart';
import 'package:breeze/src/domain/models/forecast_by_city_name_params.dart';
import 'package:breeze/src/domain/models/forecast_by_coordinates_params.dart';
import 'package:breeze/src/presentation/bloc/daily_forecast/daily_forecast_bloc.dart';
import 'package:breeze/src/presentation/bloc/daily_forecast/daily_forecast_event.dart';
import 'package:breeze/src/presentation/bloc/daily_forecast/daily_forecast_state.dart';
import 'package:breeze/src/presentation/widgets/current_weather.dart';
import 'package:breeze/src/presentation/widgets/weather_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

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
    _getCurrentPosition(dailyForecastBloc);
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
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          )),
                          leading: const Icon(
                            Icons.search,
                            color: colorSurface,
                          ),
                          hintText: 'Search',
                          onSubmitted: (String value) {
                            if (value.isNotEmpty) {
                              dailyForecastBloc.add(GetDailyForecastByCityName(
                                  ForecastByCityNameParams(cityName: value)));
                            }
                          },
                        ),
                      ),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {
                          _onSettingsButtonClicked(
                            context,
                            state.dailyForecast!.unitSystem,
                            dailyForecastBloc,
                            state.dailyForecast!.cityName,
                          );
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
                      _onNext3DaysButtonClicked(
                          context, state.dailyForecast!.cityName);
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
                ],
              ),
            ),
          );
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
            "${dailyForecast.minTemperature?.toStringAsFixed(1)}/${dailyForecast.maxTemperature?.toStringAsFixed(1)} ${_getTemperatureUnit(dailyForecast.unitSystem)}",
      ),
      WeatherInfoWidget(
        label: "WIND SPEED",
        value:
            "${dailyForecast.windSpeed} ${_getWindSpeedUnit(dailyForecast.unitSystem)}",
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

  void _onNext3DaysButtonClicked(BuildContext context, String cityName) {
    Navigator.pushNamed(context, '/MultipleDaysForecast', arguments: cityName);
  }

  void _onSettingsButtonClicked(
    BuildContext context,
    String unitSystem,
    DailyForecastBloc dailyForecastBloc,
    String cityName,
  ) async {
    final isImperialUnitSystem =
        await Navigator.pushNamed(context, '/Settings', arguments: unitSystem);
    if (isImperialUnitSystem != null &&
        isImperialUnitSystem != (unitSystem == imperialUnitSystem)) {
      dailyForecastBloc.add(GetDailyForecastByCityName(
          ForecastByCityNameParams(cityName: cityName)));
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showAlertDialog('Location services are disabled.\n\n'
          ' Please enable the services if you want to get the forecast for you current position.');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showAlertDialog('Location permissions are denied.\n\n'
            ' Please enable the location services if you want to get the forecast for you current position.');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _showLocationPermissionPermanentlyDeniedAlertDialog();
      return false;
    }
    return true;
  }

  _getCurrentPosition(DailyForecastBloc dailyForecastBloc) async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      // Default location
      dailyForecastBloc.add(GetDailyForecastByCityName(
          ForecastByCityNameParams(cityName: "Skopje")));
      return;
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      dailyForecastBloc.add(GetDailyForecastByCoordinates(
          ForecastByCoordinatesParams(
              latitude: position.latitude.toString(),
              longitude: position.longitude.toString())));
    }).catchError((e) {
      // Default location
      dailyForecastBloc.add(GetDailyForecastByCityName(
          ForecastByCityNameParams(cityName: "Skopje")));
      debugPrint(e);
    });
  }

  _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Breeze App"),
        content: Text(message),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: colorPrimary,
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text("OK",
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  _showLocationPermissionPermanentlyDeniedAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Breeze App"),
        content: const Text("Location permissions are permanently denied.\n\n"
            " Please enable the location services if you want to get the forecast for you current position."),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: colorPrimary,
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL",
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: colorPrimary,
            ),
            onPressed: () => {
              Navigator.pop(context),
              Geolocator.openAppSettings(),
            },
            child: const Text("GO TO SETTINGS",
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  _getTemperatureUnit(String unitSystem) {
    return unitSystem == metricUnitSystem ? celsiusUnit : fahrenheitUnit;
  }

  _getWindSpeedUnit(String unitSystem) {
    return unitSystem == metricUnitSystem
        ? meterPerSecondUnit
        : milesPerHourUnit;
  }
}
