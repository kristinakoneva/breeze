# Breeze - Weather App
_Developed by: Kristina Koneva (student index number: 201513)_

## Overview
Breeze is a cross-platform weather app built with Flutter using the Dart as a programming language. 

The app displays the daily and the next 3 days weather forecast for the user's current location (however, this only applies if the location permissions are granted, otherwise, the weather for a default city is displayed when launching the app). The daily forecast provides data about the current temperature, weather descaription, the minimum and maximum temperature for the day, air pressure, humidity percentage and wind speed. The forecast for the following 3 days, displays information about the minimum and maximum temperature of the specific day and a description of the weather condition.

Addtionally, the user can search for the forecast for numerous cities around the world by typing the citys' name. All successful searches are saved and the search history can be deleted upon request. 

Moreover, the app has support for both the metric and imperial user system - the user can set their preferred unit system from the app settings (the default unit system is the metric unit system).

This app is primarly intended to be used on mobile devices, however, it can successfully run on web browsers as well.

## API
The weather forecast data is provided by the [Open Weather Map API](https://openweathermap.org/). For the current weather forecast, the [Current Weather API calls](https://openweathermap.org/current) are used and for determining the forecast for the next 3 days, part of the [5 Day Weather Forecast API calls](https://openweathermap.org/forecast5) are used.

All of the API calls present in the app are currently free to use (take a look at the [Free plan](https://openweathermap.org/price)) to a certain generally sufficient limit and if you want to run and try out the app, you can obtain an API key for free by [signing up](https://home.openweathermap.org/users/sign_up). After a few hours of obtaining the key, it will become active and you will have to place it in a `api_key.dart` file in the following [directory](lib/src/data/remote) in the following format `api_key='[INSERT YOUR API KEY HERE]'`.

## Dependencies
- [Cupertino Icons](https://pub.dev/packages/cupertino_icons)
- [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
- [Equitable](https://pub.dev/packages/equatable)
- [Get It](https://pub.dev/packages/get_it)
- [Retrofit](https://pub.dev/packages/retrofit)
- [Flutter Hooks](https://pub.dev/packages/flutter_hooks)
- [Dio](https://pub.dev/packages/dio)
- [Intl](https://pub.dev/packages/intl)
- [Geolocator](https://pub.dev/packages/geolocator)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)
- [Flutter Keyboard Visibility](https://pub.dev/packages/flutter_keyboard_visibility)

For a more detailed overview of the versions used for these dependencies and the rest of the setup, check out the project's [pubspec.yaml](pubspec.yaml) file.

## Design
The app design can be found on the following [Figma link](https://www.figma.com/file/SelluHxNQHRYpyPeYN0VUJ/Breeze?type=design&node-id=0%3A1&mode=design&t=v7HfX0rFP3RTbUQU-1).

## Demo
_Click on the image to play the video demo._

<a href="[path/to/your/video.mp4](https://www.youtube.com/watch?v=HtOETUaVBgs)">
  <img src="https://github.com/kristinakoneva/breeze/assets/83497391/545b97ed-a015-4bb3-9140-43ca8250e720" alt="Demo" width=30% height=30% />
</a>

## Architecture

// TODO

