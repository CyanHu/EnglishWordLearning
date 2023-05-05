import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end_flutter/common/Global.dart';
import 'package:front_end_flutter/common/http/ewl.dart';
import 'package:front_end_flutter/components/learning_data_brief_card.dart';
import 'package:front_end_flutter/components/recent_week_input_bar_chart.dart';
import 'package:front_end_flutter/models/index.dart';


import '../../components/recent_week_time_bar_chart.dart';
import '../../models/learningDataBrief.dart';

class LearningDataSubPage extends StatefulWidget {
  const LearningDataSubPage({Key? key}) : super(key: key);

  @override
  State<LearningDataSubPage> createState() => _LearningDataSubPageState();
}

class _LearningDataSubPageState extends State<LearningDataSubPage> {
  DateTime now = DateTime.now();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<LearningDataBrief>(
              future: EWL().getLearningDataBrief(Global.profile.user!.userId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // 请求已结束
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // 请求失败，显示错误
                    return Text("Error: ${snapshot.error}");
                  } else {
                    // 请求成功，显示数据
                    return LearningDataBriefCard(learningDataBrief: snapshot.data,);
                  }
                } else {
                  // 请求未结束，显示loading
                  return CircularProgressIndicator();
                }
              },
            ),
            FutureBuilder<RecentWeekLearningData>(
              future: EWL().getRecentWeekLearningData(Global.profile.user!.userId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // 请求已结束
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // 请求失败，显示错误
                    return Text("Error: ${snapshot.error}");
                  } else {
                    // 请求成功，显示数据
                    return Column(
                      children: [
                        RecentWeekInputBarChart(wordCountList: snapshot.data.wordCountList,),
                        RecentWeekTimeBarChart(timeList: snapshot.data.timeList,),
                      ],
                    );
                  }
                } else {
                  // 请求未结束，显示loading
                  return CircularProgressIndicator();
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}
