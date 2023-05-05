import 'package:front_end_flutter/common/http/ewl.dart';
import 'package:front_end_flutter/models/index.dart';

void main() async {
  // User? user = await  EWL().login('cc', 'pcc');
  // print('${user?.username}, ${user?.avatar}, ${user?.userId}');
  // WordData? wordData = await EWL().getWordData(7);
  // print(wordData.word);
  List<Map<String, dynamic>> list11 = [{"id": 7, "title": "test1", "content": "test2", "noticeType": "系统", "noticeTime": 1682596362000, "description": "test111", "pictureUrl": null}];
  var list = list11.map((e) => Notice.fromJson(e)).toList();
  print(list[0].content);

}