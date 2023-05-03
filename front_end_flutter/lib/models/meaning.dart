import 'package:json_annotation/json_annotation.dart';

part 'meaning.g.dart';

@JsonSerializable()
class Meaning {
  Meaning();

  late String wordType;
  late String meaning;
  
  factory Meaning.fromJson(Map<String,dynamic> json) => _$MeaningFromJson(json);
  Map<String, dynamic> toJson() => _$MeaningToJson(this);
}
