import 'package:json_annotation/json_annotation.dart';

part 'hourly_units.g.dart';

@JsonSerializable()
class HourlyUnits {
  static const id = 'hourly_units';
  @JsonKey(name: 'time')
  String? time;
  @JsonKey(name: 'temperature_2m')
  String? temperature2m;

  HourlyUnits({this.time, this.temperature2m});

  factory HourlyUnits.fromJson(Map<String, dynamic> json) {
    return _$HourlyUnitsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HourlyUnitsToJson(this);
}
