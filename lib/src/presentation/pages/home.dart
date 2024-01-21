import 'package:breeze/config/theme/colors.dart';
import 'package:breeze/core/constants/constants.dart';
import 'package:breeze/src/data/local/shared_preferences.dart';
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
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> searchSuggestions = [];

  @override
  Widget build(BuildContext context) {
    DailyForecastBloc dailyForecastBloc =
        BlocProvider.of<DailyForecastBloc>(context);
    _refreshSearchSuggestions();
    _getCurrentPosition(dailyForecastBloc);
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(body: _buildBody(dailyForecastBloc, isKeyboardVisible));
    });
  }

  _buildBody(DailyForecastBloc dailyForecastBloc, bool isKeyboardVisible) {
    return BlocBuilder<DailyForecastBloc, DailyForecastState>(
      builder: (context, state) {
        if (state is DailyForecastLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else if (state is DailyForecastSuccess) {
          String cityName = state.dailyForecast!.cityName;
          addSearchSuggestion(cityName);
          if (!searchSuggestions.contains(cityName)) {
            searchSuggestions.add(cityName);
          }
          DateTime now = DateTime.now();
          String lastUpdateTime = DateFormat('HH:mm dd/MM/yy').format(now);
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
                            cityName,
                          );
                        },
                        icon: const Icon(Icons.menu),
                      )
                    ],
                  ),
                  if (isKeyboardVisible)
                    SizedBox(height: 200, child: _getListOfSearchSuggestions()),
                  CurrentWeatherWidget(
                    dailyForecast: state.dailyForecast!,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Last update: $lastUpdateTime",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          dailyForecastBloc.add(GetDailyForecastByCityName(
                              ForecastByCityNameParams(cityName: cityName)));
                        },
                        icon: const Icon(
                          Icons.refresh,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      _onNext3DaysButtonClicked(context, cityName);
                    },
                    child: const Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "NEXT 3 DAYS",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
        } else {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flex(
                      mainAxisAlignment: MainAxisAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        const Text("Something went wrong."),
                        IconButton(
                            onPressed: () {
                              _getCurrentPosition(dailyForecastBloc);
                            },
                            icon: const Icon(
                              Icons.refresh,
                              size: 30,
                            )),
                      ]),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                      "Please make sure you are searching for a valid city name and have stable Internet connection.",
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  /// Returns a list of [WeatherInfoWidget] based on the provided DailyForecast.
  _getListOfWeatherInfoWidgets(DailyForecast dailyForecast) {
    return [
      WeatherInfoWidget(
        label: "TEMPERATURE",
        value:
            "${dailyForecast.minTemperature.toStringAsFixed(1)}/${dailyForecast.maxTemperature.toStringAsFixed(1)} ${_getTemperatureUnit(dailyForecast.unitSystem)}",
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

  /// Navigates to the [MultipleDaysForecastPage] with the provided city name.
  void _onNext3DaysButtonClicked(BuildContext context, String cityName) {
    Navigator.pushNamed(context, '/MultipleDaysForecast', arguments: cityName);
  }

  /// Handles the settings button click event by navigating to the [SettingsPage]
  /// and updating the forecast if the unit system has changed.
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
    _refreshSearchSuggestions();
  }

  /// Handles the location permission logic and shows relevant dialogs.
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

  /// Retrieves the current position and updates the forecast based on the location.
  _getCurrentPosition(DailyForecastBloc dailyForecastBloc) async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      // Default location
      dailyForecastBloc.add(const GetDailyForecastByCityName(
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
      dailyForecastBloc.add(const GetDailyForecastByCityName(
          ForecastByCityNameParams(cityName: "Skopje")));
      debugPrint(e);
    });
  }

  /// Shows an alert dialog with the provided message.
  _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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

  /// Shows an alert dialog indicating that location permissions are permanently denied.
  _showLocationPermissionPermanentlyDeniedAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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

  /// Returns the temperature unit based on the provided [unitSystem].
  _getTemperatureUnit(String unitSystem) {
    return unitSystem == metricUnitSystem ? celsiusUnit : fahrenheitUnit;
  }

  /// Returns the wind speed unit based on the provided [unitSystem].
  _getWindSpeedUnit(String unitSystem) {
    return unitSystem == metricUnitSystem
        ? meterPerSecondUnit
        : milesPerHourUnit;
  }

  /// Refreshes the list of search suggestions.
  ///
  /// Retrieves updated search suggestions from local storage.
  _refreshSearchSuggestions() async {
    searchSuggestions = await getSearchSuggestions();
  }

  /// Builds a ListView of search suggestions.
  ///
  /// The suggestions are displayed in reverse order (the last searched city is displayed first).
  _getListOfSearchSuggestions() {
    return ListView.builder(
      itemCount: searchSuggestions.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          color: colorSurface,
          child: ListTile(
            shape: const Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 0.5,
              ),
            ),
            title: Text(searchSuggestions[searchSuggestions.length - index - 1],
                style: const TextStyle(color: Colors.white)),
            trailing: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            onTap: () {
              BlocProvider.of<DailyForecastBloc>(context).add(
                  GetDailyForecastByCityName(ForecastByCityNameParams(
                      cityName: searchSuggestions[
                          searchSuggestions.length - index - 1])));
            },
          ),
        );
      },
    );
  }
}
