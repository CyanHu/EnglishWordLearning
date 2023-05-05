// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learningDataBrief.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningDataBrief _$LearningDataBriefFromJson(Map<String, dynamic> json) =>
    LearningDataBrief()
      ..todayLearningData = LearningDataItem.fromJson(
          json['todayLearningData'] as Map<String, dynamic>)
      ..totalLearningData = LearningDataItem.fromJson(
          json['totalLearningData'] as Map<String, dynamic>);

Map<String, dynamic> _$LearningDataBriefToJson(LearningDataBrief instance) =>
    <String, dynamic>{
      'todayLearningData': instance.todayLearningData,
      'totalLearningData': instance.totalLearningData,
    };
