import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end_flutter/components/word_book_blank_item.dart';

import '../../common/http/ewl.dart';
import '../../models/index.dart';

class MyWordBookManagementSubPage extends StatefulWidget {
  const MyWordBookManagementSubPage({Key? key}) : super(key: key);

  @override
  State<MyWordBookManagementSubPage> createState() =>
      _MyWordBookManagementSubPageState();
}

class _MyWordBookManagementSubPageState
    extends State<MyWordBookManagementSubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => {Navigator.of(context).pop('刷新')},
          ),
          title: Text("我的单词书管理"),
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
                      if (snapshot.data.length == 0)
                        return WordBookBlankItem(text: "未创建单词书");
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

  List<TableRow> _buildTableRows(List<WordBook> wordBookList) {
    List<TableRow> res = [
      TableRow(children: [
        Text('我的单词书',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text('操作',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold)),
      ]),
    ];
    for (WordBook wordBook in wordBookList) {
      res.add(TableRow(children: [
        Text(
          wordBook.bookTitle,
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
                        return _myDialog(type: "修改", wordBook: wordBook);
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
                        return _deleteDialog(wordBook.id.toInt());
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
      content: Text("您确定要删除当前单词书吗?"),
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

  Widget _myDialog({required String type, WordBook? wordBook}) {
    final _bookTitleController =
        TextEditingController(text: wordBook?.bookTitle);
    final _bookDescriptionController =
        TextEditingController(text: wordBook?.bookDescription);
    File? file;
    return AlertDialog(
      title: Text(type),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _bookTitleController,
            decoration: InputDecoration(
                labelText: "单词书名", icon: Icon(Icons.book), hintText: "单词书名"),
          ),
          TextField(
            controller: _bookDescriptionController,
            decoration: InputDecoration(
                labelText: "单词书描述", icon: Icon(Icons.book), hintText: "单词书描述"),
          ),
          Visibility(
            visible: type == "添加",
            child: ElevatedButton.icon(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    file = File(result.files.single.path!);
                    print(result.files.single.path!);
                  } else {
                    // User canceled the picker
                  }
                },
                icon: Icon(Icons.upload),
                label: Text("上传文件")),
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
            String bookTitle = _bookTitleController.value.text;
            String bookDescription = _bookDescriptionController.value.text;
            if (bookTitle.isEmpty) {
              EasyLoading.showInfo("未输入单词书名");
              return;
            }
            if (bookDescription.isEmpty) {
              EasyLoading.showInfo("未输入单词书描述");
              return;
            }
            if (type == "添加" && file == null) {
              EasyLoading.showInfo("未上传单词书");
              return;
            }

            if (type == "添加") {
              EWL()
                  .uploadUserWordBook(
                      bookTitle: bookTitle,
                      bookDescription: bookDescription,
                      file: file!)
                  .then((value) {
                EasyLoading.showInfo(value);
                setState(() {});
                Navigator.of(context).pop(true); //关闭对话框
              });
            } else if (type == "修改") {
              if (wordBook == null) EasyLoading.showInfo("出错了");
              EWL()
                  .updateWordBook(wordBook!
                    ..bookTitle = bookTitle
                    ..bookDescription = bookDescription)
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
