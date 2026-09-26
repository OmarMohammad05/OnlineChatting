// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alternative_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlternativeTime _$AlternativeTimeFromJson(Map<String, dynamic> json) =>
    AlternativeTime(
      time: json['time'] as String,
      date: json['date'] as String,
      comfortIndex: (json['comfortIndex'] as num).toInt(),
    );

Map<String, dynamic> _$AlternativeTimeToJson(AlternativeTime instance) =>
    <String, dynamic>{
      'time': instance.time,
      'date': instance.date,
      'comfortIndex': instance.comfortIndex,
    };