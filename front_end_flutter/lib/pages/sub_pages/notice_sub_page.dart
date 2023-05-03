import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
