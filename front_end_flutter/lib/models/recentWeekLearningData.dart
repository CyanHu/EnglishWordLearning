import 'package:json_annotation/json_annotation.dart';
import "timeRecordItem.dart";
import "wordCountsRecordItem.dart";
part 'recentWeekLearningData.g.dart';

@JsonSerializable()
class RecentWeekLearningData {
  RecentWeekLearningData();

  late List<TimeRecordItem> timeList;
  late List<WordCountsRecordItem> wordCountList;
  
  factory RecentWeekLearningData.fromJson(Map<String,dynamic> json) => _$RecentWeekLearningDataFromJson(json);
  Map<String, dynamic> toJson() => _$RecentWeekLearningDataToJson(this);
}
