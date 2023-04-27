import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../weather_data/hourly.dart';
import 'dart:ui';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Temperature extends StatelessWidget {
  const Temperature({
    Key? key,
    required this.listdata,
  }) : super(key: key);

  final Hourly listdata;

  @override
  Widget build(BuildContext context) {
    final dsize = MediaQuery.of(context).size;
    final List<Data> chartData = [];

    // Convert unix timestamp to DateTime and add to chartData list
    for (int i = 0; i < listdata.time!.length; i++) {
      chartData.add(Data(
          DateFormat('hh:mm a').format(
              DateTime.fromMillisecondsSinceEpoch(listdata.time![i] * 1000)),
          listdata.temperature2m![i]));
    }
    final gradientColors = [
      Colors.blue[50]!,
      Colors.blue[200]!,
      Colors.blue[400]!,
      Colors.blue[600]!,
      Colors.blue[800]!,
      Colors.blue[900]!,
    ];
    final gradientStops = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0];
    final gradient = LinearGradient(
      colors: gradientColors,
      stops: gradientStops,
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: dsize.width * 0.3,
            height: dsize.height * 0.4,
            child: SfCartesianChart(
              enableAxisAnimation: true,
              backgroundColor: Colors.amber,
              primaryXAxis: CategoryAxis(
                labelRotation: 45,
              ),
              series: <LineSeries<Data, String>>[
                LineSeries<Data, String>(
                  animationDelay: 50,
                  dataSource: chartData,
                  xValueMapper: (Data data, _) => data.time,
                  yValueMapper: (Data data, _) => data.temperature,
                  animationDuration: 2000,
                  width: 3,
                  markerSettings: MarkerSettings(
                      isVisible: true, shape: DataMarkerType.circle),
                  enableTooltip: true,
                  dataLabelSettings: DataLabelSettings(isVisible: false),
                )
              ],
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                header: '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Data {
  Data(this.time, this.temperature);

  final String time;
  final num temperature;
}
