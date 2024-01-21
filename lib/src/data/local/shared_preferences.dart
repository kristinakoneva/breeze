import 'package:breeze/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Gets the selected unit system from shared preferences.
///
/// Returns a [Future] that completes with a [String] representing the unit system.
Future<String> getUnitSystem() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString(keyUnitSystem) ?? defaultUnitSystem;
}

/// Sets the selected unit system in shared preferences.
///
/// Requires the [unitSystem] parameter representing the unit system to be set.
///
/// Returns a [Future] that completes when the unit system is successfully set.
Future<void> setUnitSystem(String unitSystem) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString(keyUnitSystem, unitSystem);
}

/// Adds a search suggestion to the list of stored search suggestions in shared preferences.
///
/// Requires the [searchSuggestion] parameter representing the suggestion to be added.
///
/// Returns a [Future] that completes when the search suggestion is successfully added.
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

/// Gets the list of stored search suggestions from shared preferences.
///
/// Returns a [Future] that completes with a [List<String>] containing the search suggestions.
Future<List<String>> getSearchSuggestions() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getStringList(keySearchSuggestions) ?? [];
}

/// Clears the stored search suggestions in shared preferences.
///
/// Returns a [Future] that completes when the search suggestions are successfully cleared.
Future<void> clearSearchSuggestions() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove(keySearchSuggestions);
}
