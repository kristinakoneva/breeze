import 'package:breeze/src/presentation/pages/home.dart';
import 'package:breeze/src/presentation/pages/multiple_days_forecast.dart';
import 'package:breeze/src/presentation/pages/settings.dart';
import 'package:flutter/material.dart';

/// A class responsible for generating routes within the application.
class AppRoutes {
  /// Generates and returns a route based on the provided [RouteSettings].
  ///
  /// The generated route is determined by the [settings.name] value.
  ///
  /// - If the route is `'/'`, it returns a route to the [HomePage].
  /// - If the route is `'/MultipleDaysForecast'`, it returns a route to the
  ///   [MultipleDaysForecastPage] with the specified [cityName] as an argument.
  /// - If the route is `'/Settings'`, it returns a route to the [SettingsPage]
  ///   with the specified [unitSystem] as an argument.
  /// - If none of the above cases match, it defaults to the [HomePage].
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const HomePage());

      case '/MultipleDaysForecast':
        return _materialRoute(
            MultipleDaysForecastPage(cityName: settings.arguments as String));

      case '/Settings':
        return _materialRoute(
            SettingsPage(unitSystem: settings.arguments as String));

      default:
        return _materialRoute(const HomePage());
    }
  }

  /// Creates a [MaterialPageRoute] with the specified [view] widget.
  ///
  /// Returns a [Route] object representing the material-style page transition.
  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
