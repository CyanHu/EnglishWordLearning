import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end_flutter/models/index.dart';
import 'package:front_end_flutter/pages/sub_pages/learning_sub_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/Global.dart';
import '../../common/http/ewl.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({Key? key}) : super(key: key);

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  void toLearningSubPage(learningType) async {
    if (await EWL().getSelectedWordBook() == null) {
      EasyLoading.showInfo("未选择单词书");
      return;
    }
    if (learningType == "learning" &&
        Global.getNonLearningList()!.length == 0) {
      List<LearningItem> nonLearningWordIdList =
          await EWL().getNonLearningItemList();
      Global.saveNonLearningList(nonLearningWordIdList);
      Global.saveNonLearningIndex(0);
      if (nonLearningWordIdList.isEmpty) {
        EasyLoading.showInfo("已学习完所有单词");
        return;
      }
    } else if (learningType == "review" &&
        Global.getReviewList()!.length == 0) {
      List<ReviewItem> reviewWordIdList = await EWL().getReviewItemList();
      Global.saveReviewList(reviewWordIdList);
      Global.saveReviewIndex(0);
      if (reviewWordIdList.isEmpty) {
        EasyLoading.showInfo("已复习完所有单词");
        return;
      }
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LearningSubPage(learningType: learningType)));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" 学习"),
        centerTitle: true,
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => toLearningSubPage("learning"),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Learning",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FutureBuilder<LearningBrief?>(
                      future: EWL().getLearningBrief(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        // 请求已结束
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            // 请求失败，显示错误
                            return Text("Error: ${snapshot.error}");
                          } else {
                            // 请求成功，显示数据
                            if (snapshot.data == null) return SizedBox();
                            return Text(
                                snapshot.data.nonLearningWordCount.toString());
                          }
                        } else {
                          // 请求未结束，显示loading
                          return SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              )),
          SizedBox(
            width: 20,
          ),
          ElevatedButton(
              onPressed: () => toLearningSubPage("review"),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Review",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FutureBuilder<LearningBrief?>(
                      future: EWL().getLearningBrief(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        // 请求已结束
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            // 请求失败，显示错误
                            return Text("");
                            return Text("Error: ${snapshot.error}");
                          } else {
                            // 请求成功，显示数据
                            if (snapshot.data == null) return SizedBox();
                            return Text(
                                snapshot.data.needReviewWordCount.toString());
                          }
                        } else {
                          // 请求未结束，显示loading
                          return SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              )),
        ],
      )),
    );
  }
}
