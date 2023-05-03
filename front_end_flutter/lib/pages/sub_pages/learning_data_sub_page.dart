import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LearningDataSubPage extends StatefulWidget {
  const LearningDataSubPage({Key? key}) : super(key: key);

  @override
  State<LearningDataSubPage> createState() => _LearningDataSubPageState();
}

class _LearningDataSubPageState extends State<LearningDataSubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop('刷新')},
        ),
        title: Text("学习数据"),
        centerTitle: true,
      ),
    );
  }
}
