import 'package:json_annotation/json_annotation.dart';

part 'recommendation.g.dart';

enum RecommendationType { positive, warning, info }

@JsonSerializable()
class Recommendation {
  final String icon;
  final String text;
  final RecommendationType type;

  Recommendation({
    required this.icon,
    required this.text,
    required this.type,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) =>
      _$RecommendationFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationToJson(this);
}