import 'package:front_end_flutter/common/http/ewl.dart';
import 'package:front_end_flutter/models/index.dart';

void main() async {
  User? user = await  EWL().login('cc', 'pcc');
  print('${user?.username}, ${user?.avatar}, ${user?.userId}');
  WordData? wordData = await EWL().getWordData(7);
  print(wordData.word);
}