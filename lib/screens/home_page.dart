import 'package:flutter/material.dart';
import 'package:weather_app_final/data/weather_icon.dart';
import 'package:weather_app_final/data/weather_status.dart';
import 'package:weather_app_final/services/fetch_weatherdata.dart';
import 'package:weather_app_final/weather_data/current_weather.dart';
import 'package:weather_app_final/weather_data/hourly_units.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
      future: getData(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text('No data');
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              final currentWeather =
                  snapshot.data![CurrentWeather.id] as CurrentWeather;

              final unit = snapshot.data![HourlyUnits.id] as HourlyUnits?;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(weathericon(currentWeather.isDay ?? 1,
                        currentWeather.weathercode ?? 0)),
                    Text(
                      '${currentWeather.temperature ?? 'N/A'} ${unit?.temperature2m ?? 'N/A'}',
                      style: const TextStyle(
                        fontSize: 60,
                      ),
                    ),
                    Text(weatherStatus(currentWeather.weathercode ?? 0))
                  ],
                ),
              );
            }
        }
      },
    ));
  }
}
