import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end_flutter/components/notice_card.dart';
import 'package:front_end_flutter/models/index.dart';

import '../../common/http/ewl.dart';

class NoticeSubPage extends StatelessWidget {
  const NoticeSubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop('刷新')},
        ),
        title: Text("通知"),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<Notice>>(
          future: EWL().getNoticeList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // 请求已结束
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // 请求失败，显示错误
                return Text("Error: ${snapshot.error}");
              } else {
                // 请求成功，显示数据
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.separated(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return NoticeCard(notice: snapshot.data[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 50,);
                    },
                  ),
                );
              }
            } else {
              // 请求未结束，显示loading
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
