// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) => WeatherData(
      temperature: (json['temperature'] as num).toDouble(),
      feelsLike: (json['feelsLike'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
      windSpeed: (json['windSpeed'] as num).toInt(),
      windDirection: json['windDirection'] as String,
      visibility: (json['visibility'] as num).toInt(),
      uvIndex: (json['uvIndex'] as num).toInt(),
      pressure: (json['pressure'] as num).toInt(),
      comfortIndex: (json['comfortIndex'] as num).toInt(),
      condition: json['condition'] as String,
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      alternativeTimes: (json['alternativeTimes'] as List<dynamic>)
          .map((e) => AlternativeTime.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherDataToJson(WeatherData instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'feelsLike': instance.feelsLike,
      'humidity': instance.humidity,
      'windSpeed': instance.windSpeed,
      'windDirection': instance.windDirection,
      'visibility': instance.visibility,
      'uvIndex': instance.uvIndex,
      'pressure': instance.pressure,
      'comfortIndex': instance.comfortIndex,
      'condition': instance.condition,
      'recommendations': instance.recommendations,
      'alternativeTimes': instance.alternativeTimes,
    };