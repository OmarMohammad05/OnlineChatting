// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherRequest _$WeatherRequestFromJson(Map<String, dynamic> json) =>
    WeatherRequest(
      location: json['location'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      activity: $enumDecode(_$ActivityTypeEnumMap, json['activity']),
    );

Map<String, dynamic> _$WeatherRequestToJson(WeatherRequest instance) =>
    <String, dynamic>{
      'location': instance.location,
      'date': instance.date,
      'time': instance.time,
      'activity': _$ActivityTypeEnumMap[instance.activity]!,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.travel: 'travel',
  ActivityType.fishing: 'fishing',
  ActivityType.wedding: 'wedding',
  ActivityType.sports: 'sports',
  ActivityType.hiking: 'hiking',
  ActivityType.picnic: 'picnic',
};