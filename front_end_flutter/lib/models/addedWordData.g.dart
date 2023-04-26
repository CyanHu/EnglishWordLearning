// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addedWordData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddedWordData _$AddedWordDataFromJson(Map<String, dynamic> json) =>
    AddedWordData()
      ..word = json['word'] as String
      ..enPhoneticSymbol = json['enPhoneticSymbol'] as String?
      ..amPhoneticSymbol = json['amPhoneticSymbol'] as String?
      ..meanings = json['meanings'] as List<dynamic>
      ..exampleSentences = json['exampleSentences'] as List<dynamic>?;

Map<String, dynamic> _$AddedWordDataToJson(AddedWordData instance) =>
    <String, dynamic>{
      'word': instance.word,
      'enPhoneticSymbol': instance.enPhoneticSymbol,
      'amPhoneticSymbol': instance.amPhoneticSymbol,
      'meanings': instance.meanings,
      'exampleSentences': instance.exampleSentences,
    };
