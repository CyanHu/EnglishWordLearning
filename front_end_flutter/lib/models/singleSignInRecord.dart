import 'package:json_annotation/json_annotation.dart';

part 'singleSignInRecord.g.dart';

@JsonSerializable()
class SingleSignInRecord {
  SingleSignInRecord();

  late num signInDay;
  late bool signIn;
  
  factory SingleSignInRecord.fromJson(Map<String,dynamic> json) => _$SingleSignInRecordFromJson(json);
  Map<String, dynamic> toJson() => _$SingleSignInRecordToJson(this);
}
