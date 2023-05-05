import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/legend_widget.dart';
import '../models/index.dart';

class RecentWeekTimeBarChart extends StatelessWidget {
  RecentWeekTimeBarChart({super.key, required this.timeList});
  List<TimeRecordItem> timeList;

  final minutesColor = const Color(0xFF6E1BFF);
  final betweenSpace = 0.2;

  BarChartGroupData generateGroupData(
    int x,
    double minutes,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: minutes,
          color: minutesColor,
          width: 5,
        ),
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
    List<int> list1 = List.generate(7, (index) => 0);
    for (TimeRecordItem value in timeList) {
      list1[value.interval.toInt()] = value.minutes.toInt();
    }
    return List.generate(7, (index) => generateGroupData(index, list1[index].toDouble())).reversed.toList();
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
                '学习时长',
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
                Legend('学习时长', minutesColor),
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
