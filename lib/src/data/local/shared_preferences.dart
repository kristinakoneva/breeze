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

Future<void> addSearchSuggestion(String searchSuggestion) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final searchSuggestions =
      sharedPreferences.getStringList(keySearchSuggestions);
  if (searchSuggestions == null) {
    sharedPreferences.setStringList(keySearchSuggestions, [searchSuggestion]);
  } else {
    if (!searchSuggestions.contains(searchSuggestion)) {
      searchSuggestions.add(searchSuggestion);
      sharedPreferences.setStringList(keySearchSuggestions, searchSuggestions);
    }
  }
}

Future<List<String>> getSearchSuggestions() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getStringList(keySearchSuggestions) ?? [];
}

Future<void> clearSearchSuggestions() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove(keySearchSuggestions);
}
