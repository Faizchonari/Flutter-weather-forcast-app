import 'package:json_annotation/json_annotation.dart';

part 'current_weather.g.dart';

@JsonSerializable()
class CurrentWeather {
  static const id = 'current_weather';
  @JsonKey(name: 'temperature')
  double? temperature;
  @JsonKey(name: 'windspeed')
  double? windspeed;
  @JsonKey(name: 'winddirection')
  double? winddirection;
  @JsonKey(name: 'weathercode')
  int? weathercode;
  @JsonKey(name: 'is_day')
  int? isDay;
  @JsonKey(name: 'time')
  int? time;

  CurrentWeather({
    this.temperature,
    this.windspeed,
    this.winddirection,
    this.weathercode,
    this.isDay,
    this.time,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return _$CurrentWeatherFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);
}
