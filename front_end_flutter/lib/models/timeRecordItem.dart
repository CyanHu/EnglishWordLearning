import 'package:json_annotation/json_annotation.dart';

part 'timeRecordItem.g.dart';

@JsonSerializable()
class TimeRecordItem {
  TimeRecordItem();

  late num interval;
  late num minutes;
  
  factory TimeRecordItem.fromJson(Map<String,dynamic> json) => _$TimeRecordItemFromJson(json);
  Map<String, dynamic> toJson() => _$TimeRecordItemToJson(this);
}
