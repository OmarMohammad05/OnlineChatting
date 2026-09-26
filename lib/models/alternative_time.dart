import 'package:json_annotation/json_annotation.dart';

part 'alternative_time.g.dart';

@JsonSerializable()
class AlternativeTime {
  final String time;
  final String date;
  final int comfortIndex;

  const AlternativeTime({
    required this.time,
    required this.date,
    required this.comfortIndex,
  });

  factory AlternativeTime.fromJson(Map<String, dynamic> json) =>
      _$AlternativeTimeFromJson(json);

  Map<String, dynamic> toJson() => _$AlternativeTimeToJson(this);
}