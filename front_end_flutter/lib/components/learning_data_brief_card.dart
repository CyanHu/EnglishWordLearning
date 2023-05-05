import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_end_flutter/models/index.dart';

class LearningDataBriefCard extends StatelessWidget {
  const LearningDataBriefCard({Key? key, required this.learningDataBrief}) : super(key: key);
  final LearningDataBrief learningDataBrief;

  @override
  Widget build(BuildContext context) {
    List<WidgetData> widgetList = [
      WidgetData(title: "今日学习&复习", data: learningDataBrief.todayLearningData.learningWordCounts.toInt(), unit: "词"),
      WidgetData(title: "累计学习", data: learningDataBrief.totalLearningData.learningWordCounts.toInt(), unit: "词"),
      WidgetData(title: "今日学习时长", data: learningDataBrief.todayLearningData.learningMinutes.toInt(), unit: "分钟"),
      WidgetData(title: "累计学习时长", data: learningDataBrief.totalLearningData.learningMinutes.toInt(), unit: "分钟"),
    ];
    return Card(
      child: GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //宽高比为1时，子widget
          childAspectRatio: 2.5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return dataWidget(widgetData: widgetList[index]);
        },
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget dataWidget({required WidgetData widgetData}) {

    return Column(
      children: [
        Text(
          widgetData.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widgetData.data.toString(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5,),
            Text(widgetData.unit, style: TextStyle(fontSize: 10, color: Colors.grey),),
          ],
        )
      ],
    );
  }
}

class WidgetData {
  WidgetData({required this.title, required this.data, required this.unit});
  String title;
  int data;
  String unit;
}
