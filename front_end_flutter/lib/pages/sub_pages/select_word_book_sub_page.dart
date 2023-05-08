import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end_flutter/models/index.dart';

import '../../common/Global.dart';
import '../../common/http/ewl.dart';
import '../../components/notice_card.dart';
import '../../models/notice.dart';

class SelectWordBookSubPage extends StatelessWidget {
  const SelectWordBookSubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        title: Text("选择单词书"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            "我的词库",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),

              child: FutureBuilder<List<WordBook>>(
                future: EWL().getUserWordBookList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // 请求已结束
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      // 请求失败，显示错误
                      return Text("Error: ${snapshot.error}");
                    } else {
                      // 请求成功，显示数据
                      return Column(
                        children: _wordBookItemList(snapshot.data, context),
                      );
                    }
                  } else {
                    // 请求未结束，显示loading
                    return CircularProgressIndicator();
                  }
                },
              ),

              // child: Column(
              //   children: [
              //     _wordBookItem(itemTitle: '通知', itemDescription: '哈哈哈')
              //   ],
              // ),
            ),
          ),
          Text(
            "系统词库",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),

              child: FutureBuilder<List<WordBook>>(
                future: EWL().getSystemWordBookList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // 请求已结束
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      // 请求失败，显示错误
                      return Text("Error: ${snapshot.error}");
                    } else {
                      // 请求成功，显示数据
                      return Column(
                        children: _wordBookItemList(snapshot.data, context),
                      );
                    }
                  } else {
                    // 请求未结束，显示loading
                    return CircularProgressIndicator();
                  }
                },
              ),

              // child: Column(
              //   children: [
              //     _wordBookItem(itemTitle: '通知', itemDescription: '哈哈哈')
              //   ],
              // ),
            ),
          )
        ],
      ),
    );
  }

  Future<String> _update(int bookId) async {
    String str = await EWL().updateSelectedWordBook(bookId);
    if (str == "更新失败") return "更新失败";

    // List<ReviewItem> reviewWordIdList = await EWL().getReviewItemList();
    // Global.saveReviewList(reviewWordIdList);
    // Global.saveReviewIndex(0);

    List<LearningItem> nonLearningWordIdList =
        await EWL().getNonLearningItemList();
    Global.saveNonLearningList(nonLearningWordIdList);
    Global.saveNonLearningIndex(0);

    return "更新成功";
  }

  Widget _wordBookItem(
      {required String itemTitle,
      required String itemDescription,
      required int bookId,
      required BuildContext context}) {
    return InkWell(
      onTap: () {
        EasyLoading.show(status: "正在更新");
        _update(bookId).then((value) {
          EasyLoading.dismiss();
          Navigator.of(context).pop(value);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(
              Icons.book,
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Text(itemTitle),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                itemDescription,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _wordBookItemList(List<WordBook> list, BuildContext context) {
    return list
        .map<Widget>((e) => _wordBookItem(
            itemTitle: e.bookTitle,
            itemDescription: e.bookDescription,
            bookId: e.id.toInt(),
            context: context))
        .toList();
  }
}
