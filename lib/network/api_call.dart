import 'package:http/http.dart' as http;
import 'package:weather_application/constants/constants.dart';

class ApiCalls {
  static Future<http.Response> getWeather(String city) async {
    final weatherResponse = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=${Constants.weather}'));
    return weatherResponse;
  }
}
