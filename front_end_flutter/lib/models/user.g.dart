// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..userId = json['userId'] as num
  ..username = json['username'] as String
  ..avatar = json['avatar'] as String
  ..roleList =
      (json['roleList'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'avatar': instance.avatar,
      'roleList': instance.roleList,
    };
