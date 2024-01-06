import 'package:breeze/src/presentation/bloc/dailyforecast/daily_forecast_bloc.dart';
import 'package:breeze/src/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DailyForecastBloc>(
      create: (context) => serviceLocator(),
      child: MaterialApp(
        title: 'Breeze',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x000B5A56)),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
