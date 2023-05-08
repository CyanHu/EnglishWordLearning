import 'package:json_annotation/json_annotation.dart';

part 'learningItem.g.dart';

@JsonSerializable()
class LearningItem {
  LearningItem();

  late num wordId;
  late num reviewCount;
  
  factory LearningItem.fromJson(Map<String,dynamic> json) => _$LearningItemFromJson(json);
  Map<String, dynamic> toJson() => _$LearningItemToJson(this);

  @override
  String toString() {
    return 'LearningItem{wordId: $wordId, reviewCount: $reviewCount}';
  }
}
