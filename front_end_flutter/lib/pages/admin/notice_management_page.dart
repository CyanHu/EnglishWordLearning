import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end_flutter/components/word_book_blank_item.dart';

import '../../common/http/ewl.dart';
import '../../models/index.dart';

class NoticeManagementPage extends StatefulWidget {
  const NoticeManagementPage({Key? key}) : super(key: key);

  @override
  State<NoticeManagementPage> createState() =>
      _NoticeManagementPageState();
}

class _NoticeManagementPageState
    extends State<NoticeManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => {Navigator.of(context).pop('刷新')},
          ),
          title: Text("通知管理"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return _myDialog(type: "添加");
                      });
                },
                child: Text("添加")),
            SingleChildScrollView(
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
                      if (snapshot.data.length == 0)
                        return WordBookBlankItem(text: "未创建通知");
                      return Table(
                          border: TableBorder.all(),
                          children: _buildTableRows(snapshot.data));
                    }
                  } else {
                    // 请求未结束，显示loading
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ));
  }

  List<TableRow> _buildTableRows(List<Notice> noticeList) {
    List<TableRow> res = [
      TableRow(children: [
        Text('通知',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text('操作',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold)),
      ]),
    ];
    for (Notice notice in noticeList) {
      res.add(TableRow(children: [
        Text(
          notice.title,
          textAlign: TextAlign.center,
        ),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.update),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return _myDialog(type: "修改", notice: notice);
                      });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return _deleteDialog(notice.id.toInt());
                      });
                },
              ),
            ],
          ),
        )
      ]));
    }

    return res;
  }

  Widget _deleteDialog(int bookId) {
    return AlertDialog(
      title: Text("提示"),
      content: Text("您确定要删除当前通知吗?"),
      actions: <Widget>[
        TextButton(
          child: Text("取消"),
          onPressed: () => Navigator.of(context).pop(), //关闭对话框
        ),
        TextButton(
          child: Text("删除"),
          onPressed: () {
            EWL().deleteWordBook(bookId).then((value) {
              EasyLoading.showInfo(value);
              setState(() {});
            });
            Navigator.of(context).pop(true); //关闭对话框
          },
        ),
      ],
    );
  }

  Widget _myDialog({required String type, Notice? notice}) {
    final _noticeTitleController =
    TextEditingController(text: notice?.title);
    final _noticeContentController =
    TextEditingController(text: notice?.content);
    final _noticeDescriptionController =
    TextEditingController(text: notice?.description);
    return AlertDialog(
      title: Text(type),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _noticeTitleController,
            decoration: InputDecoration(
                labelText: "通知标题", icon: Icon(Icons.book), hintText: "通知标题"),
          ),
          TextField(
            controller: _noticeContentController,
            decoration: InputDecoration(
                labelText: "通知内容", icon: Icon(Icons.book), hintText: "通知内容"),
          ),
          TextField(
            controller: _noticeDescriptionController,
            decoration: InputDecoration(
                labelText: "通知描述", icon: Icon(Icons.book), hintText: "通知描述"),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text("取消"),
          onPressed: () => Navigator.of(context).pop(), //关闭对话框
        ),
        TextButton(
          child: Text(type),
          onPressed: () {
            String title = _noticeTitleController.value.text;
            String content = _noticeContentController.value.text;
            String description = _noticeDescriptionController.value.text;
            if (title.isEmpty) {
              EasyLoading.showInfo("未输入通知标题");
              return;
            }
            if (content.isEmpty) {
              EasyLoading.showInfo("未输入通知内容");
              return;
            }
            if (description.isEmpty) {
              EasyLoading.showInfo("未输入通知描述");
              return;
            }

            if (type == "添加") {
              EWL()
                  .addNotice(title: title, content: content, description: description)
                  .then((value) {
                EasyLoading.showInfo(value);
                setState(() {});
                Navigator.of(context).pop(true); //关闭对话框
              });
            } else if (type == "修改") {
              if (notice == null) EasyLoading.showInfo("出错了");
              EWL()
                  .updateNotice(notice!
                ..title = title
                ..content = content
                ..description = description)
                  .then((value) {
                EasyLoading.showInfo(value);
                setState(() {});
                Navigator.of(context).pop(true); //关闭对话框
              });
            }
          },
        ),
      ],
    );
  }
}
