import 'package:json_annotation/json_annotation.dart';

part 'wordCountsRecordItem.g.dart';

@JsonSerializable()
class WordCountsRecordItem {
  WordCountsRecordItem();

  late num interval;
  late num learningCount;
  late num reviewCount;
  
  factory WordCountsRecordItem.fromJson(Map<String,dynamic> json) => _$WordCountsRecordItemFromJson(json);
  Map<String, dynamic> toJson() => _$WordCountsRecordItemToJson(this);
}
