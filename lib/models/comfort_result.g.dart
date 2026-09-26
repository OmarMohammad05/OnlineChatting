// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comfort_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComfortResult _$ComfortResultFromJson(Map<String, dynamic> json) =>
    ComfortResult(
      comfortIndex: (json['comfortIndex'] as num).toInt(),
      status: json['status'] as String,
      weather: WeatherData.fromJson(json['weather'] as Map<String, dynamic>),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => Recommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
      alternativeTimes: (json['alternativeTimes'] as List<dynamic>)
          .map((e) => AlternativeTime.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComfortResultToJson(ComfortResult instance) =>
    <String, dynamic>{
      'comfortIndex': instance.comfortIndex,
      'status': instance.status,
      'weather': instance.weather,
      'recommendations': instance.recommendations,
      'alternativeTimes': instance.alternativeTimes,
    };
