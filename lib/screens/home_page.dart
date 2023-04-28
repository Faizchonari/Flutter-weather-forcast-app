import 'package:flutter/material.dart';
import 'package:weather_app_final/data/weather_icon.dart';
import 'package:weather_app_final/data/weather_status.dart';
import 'package:weather_app_final/screens/tempature.dart';
import 'package:weather_app_final/services/fetch_weatherdata.dart';
import 'package:weather_app_final/weather_data/current_weather.dart';
import 'package:weather_app_final/weather_data/hourly.dart';
import 'package:weather_app_final/weather_data/hourly_units.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = [
      const Tab(
        text: 'current weather',
      ),
      const Tab(
        text: 'Temparature',
      )
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: tabs,
          ),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: WeatherData.getWeatherData(Navigator.of(context)),
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
                  final listdata = snapshot.data![Hourly.id] as Hourly;
                  return TabBarView(children: [
                    NewWidget(
                        currentWeather: currentWeather,
                        unit: unit,
                        listdata: listdata),
                    Temperature(listdata: listdata)
                  ]);
                }
            }
          },
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.currentWeather,
    required this.unit,
    required this.listdata,
  });

  final CurrentWeather currentWeather;
  final HourlyUnits? unit;
  final Hourly listdata;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(weathericon(
                currentWeather.isDay ?? 1, currentWeather.weathercode ?? 0)),
            Text(
              '${currentWeather.temperature ?? 'N/A'} ${unit?.temperature2m ?? 'N/A'}',
              style: TextStyle(
                  fontSize: 60,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              weatherStatus(currentWeather.weathercode ?? 0),
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
