import 'package:breeze/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getUnitSystem() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString(keyUnitSystem) ?? defaultUnitSystem;
}

Future<void> setUnitSystem(String unitSystem) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString(keyUnitSystem, unitSystem);
}
