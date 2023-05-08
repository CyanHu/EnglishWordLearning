import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end_flutter/models/index.dart';
import 'package:front_end_flutter/pages/sub_pages/notice_sub_page.dart';
import 'package:front_end_flutter/pages/sub_pages/select_word_book_sub_page.dart';
import 'package:front_end_flutter/pages/sub_pages/user_word_book_management_sub_page.dart';

import '../../common/Global.dart';
import '../../common/http/ewl.dart';

class WordBookPage extends StatefulWidget {
  const WordBookPage({Key? key}) : super(key: key);

  @override
  State<WordBookPage> createState() => _WordBookPageState();
}

class _WordBookPageState extends State<WordBookPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("单词书"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "当前词库",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SelectWordBookSubPage(),
                        )).then((value) {
                          if (value != null) {
                            if (value == "更新成功") EasyLoading.showSuccess(value);
                            else EasyLoading.showError(value);
                            setState(() {});
                          }

                    });
                  },
                  child: Text(
                    "更换",
                    style: TextStyle(color: Colors.cyan),
                  ),
                )
              ],
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<WordBook>(
                future: EWL().getSelectedWordBook(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // 请求已结束
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      // 请求失败，显示错误
                      return Text("Error: ${snapshot.error}");
                    } else {
                      // 请求成功，显示数据
                      return _wordBookItem(
                          itemTitle: snapshot.data.bookTitle,
                          itemDescription: snapshot.data.bookDescription);
                    }
                  } else {
                    // 请求未结束，显示loading
                    return CircularProgressIndicator();
                  }
                },
              ),
              // child: _wordBookItem(itemTitle: '通知', itemDescription: '哈哈哈'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "我的词库",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UserWordBookManagementSubPage(),
                        ));
                  },
                  child: Text(
                    " 管理",
                    style: TextStyle(color: Colors.cyan),
                  ),
                )
              ],
            ),
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
                        children: _wordBookItemList(snapshot.data),
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

  Widget _wordBookItem(
      {required String itemTitle, required String itemDescription}) {
    return InkWell(
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
                style: TextStyle(fontSize: 12, color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _wordBookItemList(List<WordBook> list) {
    return list
        .map<Widget>((e) => _wordBookItem(
            itemTitle: e.bookTitle, itemDescription: e.bookDescription))
        .toList();
  }
}
