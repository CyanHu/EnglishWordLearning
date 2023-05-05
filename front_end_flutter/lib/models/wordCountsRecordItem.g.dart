// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wordCountsRecordItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordCountsRecordItem _$WordCountsRecordItemFromJson(
        Map<String, dynamic> json) =>
    WordCountsRecordItem()
      ..interval = json['interval'] as num
      ..learningCount = json['learningCount'] as num
      ..reviewCount = json['reviewCount'] as num;

Map<String, dynamic> _$WordCountsRecordItemToJson(
        WordCountsRecordItem instance) =>
    <String, dynamic>{
      'interval': instance.interval,
      'learningCount': instance.learningCount,
      'reviewCount': instance.reviewCount,
    };
