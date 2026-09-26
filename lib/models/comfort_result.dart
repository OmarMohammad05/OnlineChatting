import 'package:json_annotation/json_annotation.dart';
import 'weather_data.dart';
import 'recommendation.dart';
import 'alternative_time.dart';

part 'comfort_result.g.dart';

@JsonSerializable()
class ComfortResult {
  final int comfortIndex;
  final String status;
  final WeatherData weather;
  final List<Recommendation> recommendations;
  final List<AlternativeTime> alternativeTimes;

  ComfortResult({
    required this.comfortIndex,
    required this.status,
    required this.weather,
    required this.recommendations,
    required this.alternativeTimes,
  });

  factory ComfortResult.fromJson(Map<String, dynamic> json) =>
      _$ComfortResultFromJson(json);

  Map<String, dynamic> toJson() => _$ComfortResultToJson(this);
}