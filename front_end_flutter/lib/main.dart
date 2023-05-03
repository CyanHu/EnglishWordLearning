import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end_flutter/pages/root_page.dart';
import 'package:front_end_flutter/states/userModel.dart';
import 'package:provider/provider.dart';
import 'common/Global.dart';
import 'pages/sub_pages/login_page.dart';

void main() => Global.init().then((e) => runApp(const MyApp()));


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '咩背单词',
      home: ChangeNotifierProvider(
          create: (context) => UserModel(),
          child: RootPage()
      ),
      builder: EasyLoading.init(),
    );
  }
}