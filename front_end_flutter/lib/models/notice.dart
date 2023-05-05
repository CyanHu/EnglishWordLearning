import 'package:json_annotation/json_annotation.dart';

part 'notice.g.dart';

@JsonSerializable()
class Notice {
  Notice();

  late num id;
  late String title;
  late String content;
  late String noticeType;
  late num noticeTime;
  late String description;
  String? pictureUrl;
  
  factory Notice.fromJson(Map<String,dynamic> json) => _$NoticeFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeToJson(this);
}
