import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end_flutter/components/search_text_field.dart';
import 'package:front_end_flutter/models/index.dart';

class WordExampleMeaningManagementPage extends StatefulWidget {
  const WordExampleMeaningManagementPage({Key? key}) : super(key: key);

  @override
  State<WordExampleMeaningManagementPage> createState() =>
      _WordExampleMeaningManagementPageState();
}

class _WordExampleMeaningManagementPageState
    extends State<WordExampleMeaningManagementPage> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => {Navigator.of(context).pop('刷新')},
          ),
          title: Text("单词释义例句管理"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SearchTextField(
                controller: _searchController,
                hintText: "搜索",
                obscureText: false,
                icon: Icon(Icons.search)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(onPressed: () {}, child: Text("搜索")),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return _myDialog(type: "添加");
                          });
                    },
                    child: Text("添加")),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Table(
                      border: TableBorder.all(),
                      children: _buildTableRows(["phone", "good"])),
                ],
              ),
            ),
          ],
        ));
  }

  List<TableRow> _buildTableRows(List<String> words) {
    List<TableRow> res = [
      TableRow(children: [
        Text('单词',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text('操作',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold)),
      ]),
    ];
    for (String word in words) {
      res.add(TableRow(children: [
        Text(
          word,
          textAlign: TextAlign.center,
        ),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.update),
                onPressed: () {},
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
                        return _deleteDialog();
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

  Widget _deleteDialog() {
    return AlertDialog(
      title: Text("提示"),
      content: Text("您确定要删除当前文件吗?"),
      actions: <Widget>[
        TextButton(
          child: Text("取消"),
          onPressed: () => Navigator.of(context).pop(), //关闭对话框
        ),
        TextButton(
          child: Text("删除"),
          onPressed: () {
            // ... 执行删除操作
            Navigator.of(context).pop(true); //关闭对话框
          },
        ),
      ],
    );
  }

  Widget _myDialog({required String type, WordData? wordData}) {
    bool readOnly = type == "添加" ? false : true;
    print(readOnly);

    return AlertDialog(
      title: Text("添加"),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: wordData?.word,
                  icon: Icon(Icons.book),
                  hintText: "单词"),
              readOnly: readOnly,
              initialValue: null,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("取消"),
          onPressed: () => Navigator.of(context).pop(), //关闭对话框
        ),
        TextButton(
          child: Text("添加"),
          onPressed: () {
            // ... 执行删除操作
            Navigator.of(context).pop(true); //关闭对话框
          },
        ),
      ],
    );
  }
}
