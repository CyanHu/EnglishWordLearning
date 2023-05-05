import 'package:json_annotation/json_annotation.dart';
import "learningDataItem.dart";
part 'learningDataBrief.g.dart';

@JsonSerializable()
class LearningDataBrief {
  LearningDataBrief();

  late LearningDataItem todayLearningData;
  late LearningDataItem totalLearningData;
  
  factory LearningDataBrief.fromJson(Map<String,dynamic> json) => _$LearningDataBriefFromJson(json);
  Map<String, dynamic> toJson() => _$LearningDataBriefToJson(this);
}
