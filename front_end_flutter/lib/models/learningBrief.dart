import 'package:json_annotation/json_annotation.dart';

part 'learningBrief.g.dart';

@JsonSerializable()
class LearningBrief {
  LearningBrief();

  late num needReviewWordCount;
  late num nonLearningWordCount;
  
  factory LearningBrief.fromJson(Map<String,dynamic> json) => _$LearningBriefFromJson(json);
  Map<String, dynamic> toJson() => _$LearningBriefToJson(this);
}
