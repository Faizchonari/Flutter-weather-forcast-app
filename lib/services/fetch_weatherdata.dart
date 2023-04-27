import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather_app_final/weather_data/hourly.dart';
import 'package:weather_app_final/weather_data/hourly_units.dart';
import '../weather_data/current_weather.dart';

Future<Map<String, dynamic>> getData() async {
  final dio = Dio();
  final response = await dio.get(
      'https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m&current_weather=true&timeformat=unixtime&forecast_days=1');

  if (response.statusCode == 200) {
    final responseData = json.decode(response.toString());
    final currentWeather =
        CurrentWeather.fromJson(responseData[CurrentWeather.id]);

    final unit = HourlyUnits.fromJson(responseData[HourlyUnits.id]);
    final listofdata = Hourly.fromJson(responseData[Hourly.id]);
    return {
      CurrentWeather.id: currentWeather,
      HourlyUnits.id: unit,
      Hourly.id:listofdata,
    };
  } else {
    throw Exception(
        'Failed to load weather data, status code: ${response.statusCode}');
  }
}
