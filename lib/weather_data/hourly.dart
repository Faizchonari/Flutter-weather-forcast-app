import 'package:json_annotation/json_annotation.dart';

part 'hourly.g.dart';

@JsonSerializable()
class Hourly {
  @JsonKey(name: 'time')
  List<int>? time;
  @JsonKey(name: 'temperature_2m')
  List<num>? temperature2m;

  Hourly({this.time, this.temperature2m});

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return _$HourlyFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HourlyToJson(this);
}
