import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/http/ewl.dart';

class BookWordListSubPage extends StatelessWidget {
  const BookWordListSubPage({Key? key, required this.bookId}) : super(key: key);
  final int bookId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop('刷新')},
        ),
        title: Text("单词列表"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<String>>(
        future: EWL().getBookWordList(bookId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 请求已结束
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // 请求失败，显示错误
              return Text("Error: ${snapshot.error}");
            } else {
              // 请求成功，显示数据
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Text('${snapshot.data[index]}');
                    }),
              );
            }
          } else {
            // 请求未结束，显示loading
            return SizedBox();
          }
        },
      ),
    );
  }
}
