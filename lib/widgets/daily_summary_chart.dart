import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/workouts.dart';

class DailySummaryChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dailySummary = Provider.of<WorkoutsProvider>(context).dailySummary;
    final dates = dailySummary.keys.toList();
    final durations = dailySummary.values.toList();

    return Container(
      padding: EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: List.generate(dates.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  y: durations[index].toDouble(),
                  colors: [Colors.blue],
                ),
              ],
            );
          }),
          titlesData: FlTitlesData(
            leftTitles: SideTitles(showTitles: true),
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (context, value) => const TextStyle(color: Colors.black, fontSize: 10),
              getTitles: (double value) {
                return dates[value.toInt()];
              },
            ),
          ),
        ),
      ),
    );
  }
}
