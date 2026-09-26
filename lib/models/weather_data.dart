import 'package:json_annotation/json_annotation.dart';
import 'alternative_time.dart';

part 'weather_data.g.dart';

@JsonSerializable()
class WeatherData {
  final double temperature;
  final double feelsLike;
  final int humidity;
  final int windSpeed;
  final String windDirection;
  final int visibility;
  final int uvIndex;
  final int pressure;
  final int comfortIndex;
  final String condition;
  final List<String> recommendations;
  final List<AlternativeTime> alternativeTimes;

  const WeatherData({
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.visibility,
    required this.uvIndex,
    required this.pressure,
    required this.comfortIndex,
    required this.condition,
    required this.recommendations,
    required this.alternativeTimes,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDataToJson(this);
}