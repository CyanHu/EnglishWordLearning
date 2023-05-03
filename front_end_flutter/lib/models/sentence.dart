import 'package:json_annotation/json_annotation.dart';

part 'sentence.g.dart';

@JsonSerializable()
class Sentence {
  Sentence();

  late String sentence;
  late String sentenceTranslation;
  
  factory Sentence.fromJson(Map<String,dynamic> json) => _$SentenceFromJson(json);
  Map<String, dynamic> toJson() => _$SentenceToJson(this);
}
