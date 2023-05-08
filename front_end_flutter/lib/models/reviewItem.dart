import 'package:json_annotation/json_annotation.dart';

part 'reviewItem.g.dart';

@JsonSerializable()
class ReviewItem {
  ReviewItem();

  late num learningWordId;
  late num wordId;
  late num reviewCount;
  String? firstType;
  
  factory ReviewItem.fromJson(Map<String,dynamic> json) => _$ReviewItemFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewItemToJson(this);

  @override
  String toString() {
    return 'ReviewItem{learningWordId: $learningWordId, wordId: $wordId, reviewCount: $reviewCount, firstType: $firstType}';
  }
}
