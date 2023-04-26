import 'package:json_annotation/json_annotation.dart';

import 'current_weather.dart';
import 'hourly.dart';
import 'hourly_units.dart';

part 'weather_data.g.dart';

@JsonSerializable()
class WeatherData {
  double? latitude;
  double? longitude;
  @JsonKey(name: 'generationtime_ms')
  double? generationtimeMs;
  @JsonKey(name: 'utc_offset_seconds')
  int? utcOffsetSeconds;
  String? timezone;
  @JsonKey(name: 'timezone_abbreviation')
  String? timezoneAbbreviation;
  int? elevation;
  @JsonKey(name: 'current_weather')
  CurrentWeather? currentWeather;
  @JsonKey(name: 'hourly_units')
  HourlyUnits? hourlyUnits;
  @JsonKey(name: 'hourly')
  Hourly? hourly;

  WeatherData({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.currentWeather,
    this.hourlyUnits,
    this.hourly,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return _$WeatherDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WeatherDataToJson(this);
}
