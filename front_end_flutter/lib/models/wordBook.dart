import 'package:json_annotation/json_annotation.dart';

part 'wordBook.g.dart';

@JsonSerializable()
class WordBook {
  WordBook();

  late String bookDescription;
  late String bookTitle;
  late String bookType;
  late num id;
  num? userId;
  
  factory WordBook.fromJson(Map<String,dynamic> json) => _$WordBookFromJson(json);
  Map<String, dynamic> toJson() => _$WordBookToJson(this);
}
