import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../weather_data/hourly.dart';

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

    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: dsize.width * 0.3,
            height: dsize.height * 0.4,
            child: SfCartesianChart(
              enableAxisAnimation: true,
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
