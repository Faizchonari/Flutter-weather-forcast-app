import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app_final/screens/networkeror.dart';
import 'package:weather_app_final/weather_data/current_weather.dart';
import 'package:weather_app_final/weather_data/hourly.dart';
import 'package:weather_app_final/weather_data/hourly_units.dart';

class WeatherData {
  static const latitude = 52.52;
  static const longitude = 13.41;

  static Future<Map<String, dynamic>> getWeatherData(
      NavigatorState navigatorState) async {
    // Check internet connectivity
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No internet connection');
    }

    final dio = Dio();
    final response = await dio
        .get(
            'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m&current_weather=true&timeformat=unixtime&forecast_days=1')
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.toString());
      final currentWeather =
          CurrentWeather.fromJson(responseData[CurrentWeather.id]);

      final unit = HourlyUnits.fromJson(responseData[HourlyUnits.id]);
      final listofdata = Hourly.fromJson(responseData[Hourly.id]);
      return {
        CurrentWeather.id: currentWeather,
        HourlyUnits.id: unit,
        Hourly.id: listofdata,
      };
    } else {
      throw Exception(
          'Failed to load weather data, status code: ${response.statusCode}');
    }
  }
}

class Location {
  double? latitude;
  double? longitude;

  Future<Position?> getCurrentLocation(NavigatorState navigatorState) async {
    // check if location permission is granted
    var permission = await Permission.locationWhenInUse.status;
    if (permission == PermissionStatus.granted) {
      // permission granted, get the current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
      return position;
    } else if (permission == PermissionStatus.denied) {
      // permission denied, navigate to new page to request permission
      navigatorState.push(
        MaterialPageRoute(builder: (context) => NetworkError()),
      );
      return null;
    } else if (permission.isPermanentlyDenied) {
      // permission permanently denied, navigate to new page to request permission
      navigatorState.push(
        MaterialPageRoute(builder: (context) => NetworkError()),
      );
      return null;
    }
    return null;
  }
}
