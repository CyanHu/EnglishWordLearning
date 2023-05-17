import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end_flutter/pages/admin/notice_management_page.dart';
import 'package:front_end_flutter/pages/admin/system_word_book_management_page.dart';
import 'package:front_end_flutter/pages/admin/word_example_meaning_management_page.dart';

import '../../common/Global.dart';

class AdminRootPage extends StatelessWidget {
  const AdminRootPage({Key? key}) : super(key: key);

  static List<ButtonItem> itemList = [
    ButtonItem(buttonContent: "系统单词书管理", page: const SystemWordBookManagementPage()),
    ButtonItem(buttonContent: "通知管理", page: const NoticeManagementPage()),
    ButtonItem(buttonContent: "单词释义理解管理", page: const WordExampleMeaningManagementPage()),
  ];

  void _toPage(Widget page, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => page,
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (Global.profile.user!.roleList.contains("ROLE_ADMIN")) {
      EasyLoading.showSuccess("成功");
    } else {
      EasyLoading.showError("该用户没有权限").then((value) => Navigator.pop(context));
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop('刷新')},
        ),
        title: Text("管理端"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return ElevatedButton(
                  onPressed: () {
                    _toPage(itemList[index].page, context);
                  },
                  child: Text(itemList[index].buttonContent));
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: itemList.length,
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }
}

class ButtonItem {
  ButtonItem({required this.buttonContent, required this.page});
  String buttonContent;
  Widget page;
}
