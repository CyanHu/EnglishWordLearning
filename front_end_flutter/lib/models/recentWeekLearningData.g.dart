// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recentWeekLearningData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentWeekLearningData _$RecentWeekLearningDataFromJson(
        Map<String, dynamic> json) =>
    RecentWeekLearningData()
      ..timeList = (json['timeList'] as List<dynamic>)
          .map((e) => TimeRecordItem.fromJson(e as Map<String, dynamic>))
          .toList()
      ..wordCountList = (json['wordCountList'] as List<dynamic>)
          .map((e) => WordCountsRecordItem.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$RecentWeekLearningDataToJson(
        RecentWeekLearningData instance) =>
    <String, dynamic>{
      'timeList': instance.timeList,
      'wordCountList': instance.wordCountList,
    };
