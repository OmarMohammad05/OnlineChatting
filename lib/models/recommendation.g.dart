// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recommendation _$RecommendationFromJson(Map<String, dynamic> json) =>
    Recommendation(
      icon: json['icon'] as String,
      text: json['text'] as String,
      type: $enumDecode(_$RecommendationTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$RecommendationToJson(Recommendation instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'text': instance.text,
      'type': _$RecommendationTypeEnumMap[instance.type]!,
    };

const _$RecommendationTypeEnumMap = {
  RecommendationType.positive: 'positive',
  RecommendationType.warning: 'warning',
  RecommendationType.info: 'info',
};
