// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_units.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyUnits _$HourlyUnitsFromJson(Map<String, dynamic> json) => HourlyUnits(
      time: json['time'] as String?,
      temperature2m: json['temperature_2m'] as String?,
    );

Map<String, dynamic> _$HourlyUnitsToJson(HourlyUnits instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temperature_2m': instance.temperature2m,
    };
