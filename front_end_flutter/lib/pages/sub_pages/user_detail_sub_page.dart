import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end_flutter/common/http/ewl.dart';
import 'package:provider/provider.dart';

import '../../common/Global.dart';
import '../../states/userModel.dart';

class UserDetailSubPage extends StatefulWidget {
  const UserDetailSubPage({Key? key}) : super(key: key);

  @override
  State<UserDetailSubPage> createState() => _UserDetailSubPageState();
}

class _UserDetailSubPageState extends State<UserDetailSubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop('刷新')},
        ),
        title: Text("用户信息"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            EWL().logout();
            EasyLoading.showSuccess("登出成功").then((value) {
              Navigator.pop(context);
            });
          },
          child: Text("登出"),
        ),
      ),
    );
  }
}
