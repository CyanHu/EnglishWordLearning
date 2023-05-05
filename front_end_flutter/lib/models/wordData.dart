import 'package:json_annotation/json_annotation.dart';
import "meaning.dart";
import "sentence.dart";
part 'wordData.g.dart';

@JsonSerializable()
class WordData {
  WordData();

  late num wordId;
  late String word;
  String? enPhoneticSymbol;
  String? amPhoneticSymbol;
  late List<Meaning> meanings;
  List<Sentence>? exampleSentences;
  
  factory WordData.fromJson(Map<String,dynamic> json) => _$WordDataFromJson(json);
  Map<String, dynamic> toJson() => _$WordDataToJson(this);
}
