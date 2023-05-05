// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notice _$NoticeFromJson(Map<String, dynamic> json) => Notice()
  ..id = json['id'] as num
  ..title = json['title'] as String
  ..content = json['content'] as String
  ..noticeType = json['noticeType'] as String
  ..noticeTime = json['noticeTime'] as num
  ..description = json['description'] as String
  ..pictureUrl = json['pictureUrl'] as String?;

Map<String, dynamic> _$NoticeToJson(Notice instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'noticeType': instance.noticeType,
      'noticeTime': instance.noticeTime,
      'description': instance.description,
      'pictureUrl': instance.pictureUrl,
    };
