// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wordData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordData _$WordDataFromJson(Map<String, dynamic> json) => WordData()
  ..word = json['word'] as String
  ..enPhoneticSymbol = json['enPhoneticSymbol'] as String?
  ..amPhoneticSymbol = json['amPhoneticSymbol'] as String?
  ..meanings = (json['meanings'] as List<dynamic>)
      .map((e) => Meaning.fromJson(e as Map<String, dynamic>))
      .toList()
  ..exampleSentences = (json['exampleSentences'] as List<dynamic>?)
      ?.map((e) => Sentence.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$WordDataToJson(WordData instance) => <String, dynamic>{
      'word': instance.word,
      'enPhoneticSymbol': instance.enPhoneticSymbol,
      'amPhoneticSymbol': instance.amPhoneticSymbol,
      'meanings': instance.meanings,
      'exampleSentences': instance.exampleSentences,
    };
