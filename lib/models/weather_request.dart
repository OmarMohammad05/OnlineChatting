import 'package:json_annotation/json_annotation.dart';
import 'activity_type.dart';

part 'weather_request.g.dart';

@JsonSerializable()
class WeatherRequest {
  final String location;
  final String date;
  final String time;
  final ActivityType activity;

  const WeatherRequest({
    required this.location,
    required this.date,
    required this.time,
    required this.activity,
  });

  factory WeatherRequest.fromJson(Map<String, dynamic> json) =>
      _$WeatherRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherRequestToJson(this);
}