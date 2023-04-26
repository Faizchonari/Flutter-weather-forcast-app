// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) =>
    CurrentWeather(
      temperature: (json['temperature'] as num?)?.toDouble(),
      windspeed: (json['windspeed'] as num?)?.toDouble(),
      winddirection: (json['winddirection'] as num?)?.toDouble(),
      weathercode: json['weathercode'] as int?,
      isDay: json['is_day'] as int?,
      time: json['time'] as int?,
    );

Map<String, dynamic> _$CurrentWeatherToJson(CurrentWeather instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'windspeed': instance.windspeed,
      'winddirection': instance.winddirection,
      'weathercode': instance.weathercode,
      'is_day': instance.isDay,
      'time': instance.time,
    };
