// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'singleSignInRecord.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleSignInRecord _$SingleSignInRecordFromJson(Map<String, dynamic> json) =>
    SingleSignInRecord()
      ..signInDay = json['signInDay'] as num
      ..signIn = json['signIn'] as bool;

Map<String, dynamic> _$SingleSignInRecordToJson(SingleSignInRecord instance) =>
    <String, dynamic>{
      'signInDay': instance.signInDay,
      'signIn': instance.signIn,
    };
