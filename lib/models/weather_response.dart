import 'package:json_annotation/json_annotation.dart';
import 'weather_data.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  final bool success;
  final WeatherData? data;
  final String? message;

  const WeatherResponse({
    required this.success,
    this.data,
    this.message,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}