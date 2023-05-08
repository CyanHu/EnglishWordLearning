// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wordBook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordBook _$WordBookFromJson(Map<String, dynamic> json) => WordBook()
  ..bookDescription = json['bookDescription'] as String
  ..bookTitle = json['bookTitle'] as String
  ..bookType = json['bookType'] as String
  ..id = json['id'] as num
  ..userId = json['userId'] as num?;

Map<String, dynamic> _$WordBookToJson(WordBook instance) => <String, dynamic>{
      'bookDescription': instance.bookDescription,
      'bookTitle': instance.bookTitle,
      'bookType': instance.bookType,
      'id': instance.id,
      'userId': instance.userId,
    };
