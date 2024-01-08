import 'package:breeze/src/presentation/pages/home.dart';
import 'package:breeze/src/presentation/pages/multiple_days_forecast.dart';
import 'package:breeze/src/presentation/pages/settings.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const HomePage());

      case '/MultipleDaysForecast':
        return _materialRoute(
            MultipleDaysForecastPage(cityName: settings.arguments as String));

      case '/Settings':
        return _materialRoute(const SettingsPage());

      default:
        return _materialRoute(const HomePage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
