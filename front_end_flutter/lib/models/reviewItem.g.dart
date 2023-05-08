// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviewItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewItem _$ReviewItemFromJson(Map<String, dynamic> json) => ReviewItem()
  ..learningWordId = json['learningWordId'] as num
  ..wordId = json['wordId'] as num
  ..reviewCount = json['reviewCount'] as num
  ..firstType = json['firstType'] as String?;

Map<String, dynamic> _$ReviewItemToJson(ReviewItem instance) =>
    <String, dynamic>{
      'learningWordId': instance.learningWordId,
      'wordId': instance.wordId,
      'reviewCount': instance.reviewCount,
      'firstType': instance.firstType,
    };
