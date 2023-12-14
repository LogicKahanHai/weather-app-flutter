class WeatherModel {
  final String cityName;
  final double temperature;
  final String iconCode;
  final String weatherMain;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.iconCode,
    required this.weatherMain,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'],
      iconCode: json['weather'][0]['icon'],
      weatherMain: json['weather'][0]['main'],
    );
  }
}
