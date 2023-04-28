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
        listdata.temperature2m![i],
        listdata.temperature_80m![i],
        listdata.temperature_120m![i],
        listdata.temperature_180m![i],
      ));
    }

    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.green,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SfCartesianChart(
              enableAxisAnimation: true,
              primaryXAxis: CategoryAxis(
                labelRotation: 45,
                labelStyle: TextStyle(color: Colors.red),
              ),
              primaryYAxis: NumericAxis(
                majorGridLines: null,
                minorGridLines: null,
                labelStyle: TextStyle(color: Colors.red),
              ),
              series: <LineSeries<Data, String>>[
                createLineSeries(chartData, (data, _) => data.temperature),
                createLineSeries(chartData, (data, _) => data.temperature80),
                createLineSeries(chartData, (data, _) => data.temperature120),
                createLineSeries(chartData, (data, _) => data.temperature180),
              ],
              legend: Legend(
                title: LegendTitle(text: 'temp'),
                iconBorderColor: Colors.red,
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                header: '',
                animationDuration: 500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineSeries<Data, String> createLineSeries(
    List<Data> dataSource,
    num Function(Data, int) yValueMapper,
  ) {
    return LineSeries<Data, String>(
      animationDelay: 50,
      dataSource: dataSource,
      xValueMapper: (Data data, _) => data.time,
      yValueMapper: yValueMapper,
      animationDuration: 2000,
      width: 3,
      markerSettings:
          MarkerSettings(isVisible: true, shape: DataMarkerType.circle),
      enableTooltip: true,
      dataLabelSettings: DataLabelSettings(isVisible: false),
    );
  }
}

class Data {
  Data(this.time, this.temperature, this.temperature80, this.temperature120,
      this.temperature180);

  final String time;
  final num temperature;
  final num temperature80;
  final num temperature120;
  final num temperature180;
}
