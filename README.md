# Breeze - Weather App

_Developed by: Kristina Koneva (student index number: 201513)_

## Overview

Breeze is a cross-platform weather app built with Flutter using the Dart as a programming language.

The app displays the daily and the next 3 days weather forecast for the user's current location (however, this only applies if the location
permissions are granted, otherwise, the weather for a default city is displayed when launching the app). The daily forecast provides data
about the current temperature, weather description, the minimum and maximum temperature for the day, air pressure, humidity percentage and
wind speed. The forecast for the following 3 days, displays information about the minimum and maximum temperature of the specific day and a
description of the weather condition.

Additionally, the user can search for the forecast for numerous cities around the world by typing the city's name. All successful searches
are saved and the search history can be deleted upon request.

Moreover, the app has support for both the metric and imperial user system - the user can set their preferred unit system from the app
settings (the default unit system is the metric unit system).

This app is primarily intended to be used on mobile devices, however, it can successfully run on web browsers as well.

Breeze requires Internet connection to function properly.

The app code is documented following the [DartDoc](https://dart.dev/effective-dart/documentation) format.

## API

The weather forecast data is provided by the [Open Weather Map API](https://openweathermap.org/). For the current weather forecast,
the [Current Weather API calls](https://openweathermap.org/current) are used and for determining the forecast for the next 3 days, part of
the [5 Day Weather Forecast API calls](https://openweathermap.org/forecast5) are used.

All of the API calls present in the app are currently free to use (take a look at the [Free plan](https://openweathermap.org/price)) to a
certain generally sufficient limit and if you want to run and try out the app, you can obtain an API key for free
by [signing up](https://home.openweathermap.org/users/sign_up). After a few hours of obtaining the key, it will become active and you will
have to place it in a `api_key.dart` file in the following [directory](lib/src/data/remote) in the following
format `api_key='[INSERT YOUR API KEY HERE]'`.

## Dependencies

- [Cupertino Icons](https://pub.dev/packages/cupertino_icons)
- [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
- [Equitable](https://pub.dev/packages/equatable)
- [Get It](https://pub.dev/packages/get_it)
- [Retrofit](https://pub.dev/packages/retrofit)
- [Flutter Hooks](https://pub.dev/packages/flutter_hooks)
- [Dio](https://pub.dev/packages/dio)
- [Intl](https://pub.dev/packages/intl)
- [Geo Locator](https://pub.dev/packages/geolocator)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)
- [Flutter Keyboard Visibility](https://pub.dev/packages/flutter_keyboard_visibility)

For a more detailed overview of the versions used for these dependencies and the rest of the setup, check out the
project's [pubspec.yaml](pubspec.yaml) file.

## Design

The app design can be found on the
following [Figma link](https://www.figma.com/file/SelluHxNQHRYpyPeYN0VUJ/Breeze?type=design&node-id=0%3A1&mode=design&t=v7HfX0rFP3RTbUQU-1).
The app is available in portrait mode only.

## Theme

This app follows the [Material Design](https://m3.material.io/) design system. The app colors are defined in
the [colors.dart](lib/config/theme/colors.dart) file and the theme is defined in the [theme.dart](lib/config/theme/theme.dart) file in
the [config](lib/config) directory.

## Demo

_Click on the image to play the video demo._

<a href="https://www.youtube.com/watch?v=mEx6TKCwT9M">
  <img src="https://github.com/kristinakoneva/breeze/assets/83497391/25c3c498-260d-4768-a631-ee9da794d738" alt="Demo" width=30% height=30% />
</a>

## Architecture

This app is divided into three layers: data, domain and presentation layer. The state management is handled following the BLoC pattern.

### Data Layer

The data layer consists of two data sources:

- remote source (the API service which provides the API for fetching the weather forecasts)
- local source (shared preferences which locally provides and stores the chosen unit system and the search suggestions from the search
  history).

### Domain Layer

The domain layer serves as a connection between the data and the domain layer. It consists of domain models, repositories and use cases. The
data models - responses from the remote API source are transformed into domain models in this layer. The repositories provide an interface
for communicating with the data sources and their interface is used by the use cases. The use cases are defined in the domain layer and used
in the presentation layer. They serve as an abstracted clean link to the data sources (without knowing their implementation and origin) in
the presentation layer. All use cases extend from the custom [`UseCase<Type, Params>`](lib/core/use_case/use_case.dart) class.

### Presentation Layer

The presentation layer is the UI - what the user sees on the screen. It consists of

- pages - the UI for each screen of the app
- widgets - custom views used in the pages
- events - user actions which can trigger a state change
- states - represent the current state of the app
- blocs - consume events, process them and change the app state appropriately.

Additionally, the following concepts contribute to the easier and cleaner state management:

- `BlocProvider` - a widget provided by the [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) package that adds a `Bloc` to the widget
  tree, ensures that the `Bloc` is created only once and is accessible to all the widgets in the subtree
- `BlocBuilder` - a widget provided by the [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) package that helps to connect the `Bloc`
  to the user interface, listens to changes in the state of the `Bloc` and rebuilds the UI accordingly.

## Dependency Injection

For simple dependency injection, this app uses the [get_it](https://pub.dev/packages/get_it) Service Locator. This service locator provides
Dio, all of the blocs and use cases, the repositories and the API service inside
the [injection_container.dart](lib/injection_container.dart).
