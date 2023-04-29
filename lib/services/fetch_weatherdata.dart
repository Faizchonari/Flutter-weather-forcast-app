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
  static Future<Map<String, dynamic>> getWeatherData(
      NavigatorState navigatorState) async {
    // Check internet connectivity
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No internet connection');
    }
    LocationData locationData = LocationData();
    Position? position = await locationData.getCurrentLocation(navigatorState);
    if (position == null) {
      throw Exception('Failed to get current location');
    }
    final latitude = position.latitude;
    final longitude = position.longitude;
    final dio = Dio();
    final response = await dio
        .get(
            'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,temperature_80m,temperature_120m,temperature_180m&current_weather=true&timeformat=unixtime&forecast_days=1')
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

class LocationData {
  double? latitude;
  double? longitude;

  Future<Position?> getCurrentLocation(NavigatorState navigatorState) async {
    // check if location permission is granted
    var permission = await Permission.locationWhenInUse.status;
    if (permission == PermissionStatus.granted) {
      // permission granted, get the current location
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        latitude = position.latitude;
        longitude = position.longitude;
        return position;
      } catch (e) {
        throw Exception('Failed to get current location');
      }
    } else if (permission == PermissionStatus.denied ||
        permission.isPermanentlyDenied) {
      // permission denied, request location permission
      var status = await Permission.locationWhenInUse.request();
      if (status == PermissionStatus.granted) {
        // permission granted, get the current location
        try {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          latitude = position.latitude;
          longitude = position.longitude;
          return position;
        } catch (e) {
          throw Exception('Failed to get current location');
        }
      } else {
        // permission still not granted, show alert dialog
        showDialog(
          context: navigatorState.context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Location Permission Required'),
              content: Text(
                  'Please allow the app to access your location to use this feature.'),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text('Open Settings'),
                  onPressed: () {
                    openAppSettings();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
    return null;
  }
}
