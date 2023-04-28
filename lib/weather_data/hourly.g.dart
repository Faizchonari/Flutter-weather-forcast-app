// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hourly _$HourlyFromJson(Map<String, dynamic> json) => Hourly(
      time: (json['time'] as List<dynamic>?)?.map((e) => e as int).toList(),
      temperature2m: (json['temperature_2m'] as List<dynamic>?)
          ?.map((e) => e as num)
          .toList(),
      temperature_80m: (json['temperature_80m'] as List<dynamic>?)
          ?.map((e) => e as num)
          .toList(),
      temperature_120m: (json['temperature_120m'] as List<dynamic>?)
          ?.map((e) => e as num)
          .toList(),
      temperature_180m: (json['temperature_180m'] as List<dynamic>?)
          ?.map((e) => e as num)
          .toList(),
    );

Map<String, dynamic> _$HourlyToJson(Hourly instance) => <String, dynamic>{
      'time': instance.time,
      'temperature_2m': instance.temperature2m,
      'temperature_80m': instance.temperature_80m,
      'temperature_120m': instance.temperature_120m,
      'temperature_180m': instance.temperature_180m,
    };
