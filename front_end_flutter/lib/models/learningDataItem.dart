import 'package:json_annotation/json_annotation.dart';

part 'learningDataItem.g.dart';

@JsonSerializable()
class LearningDataItem {
  LearningDataItem();

  late num learningMinutes;
  late num learningWordCounts;
  
  factory LearningDataItem.fromJson(Map<String,dynamic> json) => _$LearningDataItemFromJson(json);
  Map<String, dynamic> toJson() => _$LearningDataItemToJson(this);
}
