import 'dart:convert';

import 'package:weather_application/models/weather_model.dart';
import 'package:weather_application/network/api_call.dart';

class WeatherRepository {
  static List<String> _favouriteLocations = [];
  static List<String> _pastLocations = [];

  static List<String> get favouriteLocations => _favouriteLocations;
  static List<String> get pastLocations => _pastLocations;

  static set favouriteLocations(List<String> locations) {
    _favouriteLocations = locations;
  }

  static set pastLocations(List<String> locations) {
    _pastLocations = locations;
  }

  static void addFavouriteLocation(String city) {
    _favouriteLocations.add(city);
  }

  static void addSearch(String city) {
    _pastLocations.add(city);
  }

  static void removeSearch(String city) {
    _pastLocations.remove(city);
  }

  static void removeFavouriteLocation(String city) {
    _favouriteLocations.remove(city);
  }

  static Future<WeatherModel> getWeather(String city) async {
    final weatherResponse = await ApiCalls.getWeather(city);
    if (weatherResponse.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(weatherResponse.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
