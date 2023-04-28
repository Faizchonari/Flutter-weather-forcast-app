import 'package:json_annotation/json_annotation.dart';

part 'hourly.g.dart';

@JsonSerializable()
class Hourly {
  static const id = 'hourly';
  @JsonKey(name: 'time')
  List<int>? time;
  @JsonKey(name: 'temperature_2m')
  List<num>? temperature2m;
  @JsonKey(name: 'temperature_80m')
  List<num>? temperature_80m;
  @JsonKey(name: 'temperature_120m')
  List<num>? temperature_120m;
  @JsonKey(name: 'temperature_180m')
  List<num>? temperature_180m;

  Hourly(
      {this.time,
      this.temperature2m,
      this.temperature_80m,
      this.temperature_120m,
      this.temperature_180m});

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return _$HourlyFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HourlyToJson(this);
}
