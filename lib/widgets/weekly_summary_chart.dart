import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/workouts.dart';

class WeeklySummaryChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weeklySummary = Provider.of<WorkoutsProvider>(context).weeklySummary;
    final weeks = weeklySummary.keys.toList();
    final durations = weeklySummary.values.toList();

    return Container(
      padding: EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(weeks.length, (index) {
                return FlSpot(index.toDouble(), durations[index].toDouble());
              }),
              isCurved: true,
              colors: [Colors.blue],
              barWidth: 4,
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: SideTitles(showTitles: true),
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (context, value) => const TextStyle(color: Colors.black, fontSize: 10),
              getTitles: (double value) {
                return weeks[value.toInt()];
              },
            ),
          ),
        ),
      ),
    );
  }
}
