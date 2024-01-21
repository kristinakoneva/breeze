import 'package:breeze/config/routes/routes.dart';
import 'package:breeze/config/theme/theme.dart';
import 'package:breeze/src/presentation/bloc/daily_forecast/daily_forecast_bloc.dart';
import 'package:breeze/src/presentation/bloc/multiple_days_forecast/multiple_days_forecast_bloc.dart';
import 'package:breeze/src/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes the dependency injection container.
  await initializeDependencies();

  // Locks the device orientation to portrait mode.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<DailyForecastBloc>(
          create: (BuildContext context) => serviceLocator(),
        ),
        BlocProvider<MultipleDaysForecastBloc>(
          create: (BuildContext context) => serviceLocator(),
        ),
      ],
      child: const BreezeApp(),
    ),
  );
}

class BreezeApp extends StatelessWidget {
  const BreezeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breeze',
      theme: theme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: const HomePage(),
    );
  }
}
