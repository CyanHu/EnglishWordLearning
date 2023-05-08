import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end_flutter/pages/sub_pages/learning_sub_page.dart';

import '../../common/Global.dart';
import '../../common/http/ewl.dart';
import '../../models/index.dart';

class LearningFinishSubPage extends StatelessWidget {
  const LearningFinishSubPage({Key? key, required this.learningType})
      : super(key: key);
  final String learningType;

  void _nextGroupButton(BuildContext context) async {

    String res;
    if (learningType == "learning") {
      //添加学习单词数

      res = await EWL().learning();
      List<LearningItem> nonLearningWordIdList =
          await EWL().getNonLearningItemList();
      Global.saveNonLearningList(nonLearningWordIdList);
      Global.saveNonLearningIndex(0);
      if (nonLearningWordIdList.isEmpty) {
        EasyLoading.showInfo("已学习完所有单词").then((value) {
          Navigator.pop(context);
        });
        return;
      }
    } else if (learningType == "review") {
      res = await EWL().review();
      List<ReviewItem> reviewWordIdList = await EWL().getReviewItemList();
      Global.saveReviewList(reviewWordIdList);
      Global.saveReviewIndex(0);
      if (reviewWordIdList.isEmpty) {
        EasyLoading.showInfo("已复习完所有单词").then((value) {
          Navigator.pop(context);
        });
        return;
      }
    }
    Route route = MaterialPageRoute(
        builder: (context) => LearningSubPage(
              learningType: learningType,
            ));
    Navigator.pushReplacement(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop('刷新')},
        ),
        title: Text("完成"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("该组已完成"),
              ElevatedButton(
                  onPressed: () => _nextGroupButton(context), child: Text("下一组")),
            ],
          )),
    );

  }
}
