import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end_flutter/pages/sub_pages/notice_sub_page.dart';

class WordBookPage extends StatefulWidget {
  const WordBookPage({Key? key}) : super(key: key);

  @override
  State<WordBookPage> createState() => _WordBookPageState();
}

class _WordBookPageState extends State<WordBookPage> {
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
                Text(
                  "更换",
                  style: TextStyle(color: Colors.cyan),
                )
              ],
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [_wordBookleItem(NoticeSubPage(), 'notice', '通知')],
              ),
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
                Text("管理", style: TextStyle(color: Colors.cyan),)
              ],
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [_wordBookleItem(NoticeSubPage(), 'notice', '通知')],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _wordBookleItem(
      Widget navWidget, String urlString, String itemString) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => navWidget,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Image.asset(
              "lib/assets/images/$urlString.png",
              height: 20,
              width: 20,
              color: Colors.cyan,
            ),
            SizedBox(
              width: 10,
            ),
            Text(itemString),
            Expanded(child: SizedBox()),
            Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
}
