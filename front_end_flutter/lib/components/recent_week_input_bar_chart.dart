import 'dart:collection';
import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/index.dart';
import 'legend_widget.dart';

class RecentWeekInputBarChart extends StatelessWidget {
  RecentWeekInputBarChart({super.key, required this.wordCountList});
  List<WordCountsRecordItem> wordCountList;

  final learningColor = const Color(0xFF6E1BFF);
  final reviewColor = const Color(0xFF50E4FF);
  final betweenSpace = 0.2;

  BarChartGroupData generateGroupData(
    int x,
    double learning,
    double review,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: learning,
          color: learningColor,
          width: 5,
        ),
        BarChartRodData(
          fromY: learning + betweenSpace,
          toY: learning + betweenSpace + review,
          color: reviewColor,
          width: 5,
        )
      ],
    );
  }

  final DateTime now = DateTime.now();

  Text lastWeekText(int interval) {
    const style = TextStyle(fontSize: 10);
    String text;
    if (interval == 0) {
      text = "今日";
    } else if (interval > 0 && interval < 7) {
      text = DateFormat.Md().format(now.subtract(Duration(days: interval)));
    } else {
      text = '';
    }
    return Text(
      text,
      style: style,
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: lastWeekText(value.toInt()),
    );
  }


  List<BarChartGroupData> getBarCharGroupDataList() {
    List<CountItem> list1 = List.generate(7, (index) => CountItem());
    for (WordCountsRecordItem value in wordCountList) {
      list1[value.interval.toInt()] = CountItem(learningCount: value.learningCount.toInt(), reviewCount: value.reviewCount.toInt());
    }
    return List.generate(7, (index) => generateGroupData(index, list1[index].learningCount.toDouble(), list1[index].learningCount.toDouble())).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Text(
                ' 单词输入量',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20,),
            const Text(
              '最近一周',
              style: TextStyle(
                color: Color(0xFF2196F3),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            LegendsListWidget(
              legends: [
                Legend('学习', learningColor),
                Legend('复习', reviewColor),
              ],
            ),
            const SizedBox(height: 14),
            AspectRatio(
              aspectRatio: 2,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(),
                    rightTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 20,
                      ),
                    ),
                  ),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.white,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          var rod = group.barRods[rodIndex];
                          return BarTooltipItem(
                              (rod.toY.toInt() - rod.fromY.toInt()).toString() , TextStyle(color: Colors.black));
                        }),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  barGroups: getBarCharGroupDataList(),
                  maxY: 11 + (betweenSpace * 3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CountItem {
  CountItem({this.learningCount = 0, this.reviewCount = 0});
  int learningCount;
  int reviewCount;
}
