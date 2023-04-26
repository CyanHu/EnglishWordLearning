import 'package:json_annotation/json_annotation.dart';

part 'addedWordData.g.dart';

@JsonSerializable()
class AddedWordData {
  AddedWordData();

  late String word;
  String? enPhoneticSymbol;
  String? amPhoneticSymbol;
  late List meanings;
  List? exampleSentences;
  
  factory AddedWordData.fromJson(Map<String,dynamic> json) => _$AddedWordDataFromJson(json);
  Map<String, dynamic> toJson() => _$AddedWordDataToJson(this);
}
