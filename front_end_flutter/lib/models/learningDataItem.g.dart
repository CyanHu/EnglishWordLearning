// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learningDataItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningDataItem _$LearningDataItemFromJson(Map<String, dynamic> json) =>
    LearningDataItem()
      ..learningMinutes = json['learningMinutes'] as num
      ..learningWordCounts = json['learningWordCounts'] as num;

Map<String, dynamic> _$LearningDataItemToJson(LearningDataItem instance) =>
    <String, dynamic>{
      'learningMinutes': instance.learningMinutes,
      'learningWordCounts': instance.learningWordCounts,
    };
