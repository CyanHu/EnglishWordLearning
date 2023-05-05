// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeRecordItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeRecordItem _$TimeRecordItemFromJson(Map<String, dynamic> json) =>
    TimeRecordItem()
      ..interval = json['interval'] as num
      ..minutes = json['minutes'] as num;

Map<String, dynamic> _$TimeRecordItemToJson(TimeRecordItem instance) =>
    <String, dynamic>{
      'interval': instance.interval,
      'minutes': instance.minutes,
    };
