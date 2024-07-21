import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workouts.dart';
import '../widgets/daily_summary_chart.dart';
import '../widgets/weekly_summary_chart.dart';

class SummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Summary'),
        bottom: TabBar(
          tabs: [
            Tab(text: 'Daily'),
            Tab(text: 'Weekly'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          DailySummary(),
          WeeklySummary(),
        ],
      ),
    );
  }
}

class DailySummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dailySummary = Provider.of<WorkoutsProvider>(context).dailySummary;
    return Column(
      children: [
        Expanded(child: DailySummaryChart()),
        Expanded(
          child: ListView.builder(
            itemCount: dailySummary.length,
            itemBuilder: (ctx, index) {
              String date = dailySummary.keys.elementAt(index);
              int duration = dailySummary[date]!;
              return ListTile(
                title: Text(date),
                subtitle: Text('$duration minutes'),
              );
            },
          ),
        ),
      ],
    );
  }
}

class WeeklySummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weeklySummary = Provider.of<WorkoutsProvider>(context).weeklySummary;
    return Column(
      children: [
        Expanded(child: WeeklySummaryChart()),
        Expanded(
          child: ListView.builder(
            itemCount: weeklySummary.length,
            itemBuilder: (ctx, index) {
              String week = weeklySummary.keys.elementAt(index);
              int duration = weeklySummary[week]!;
              return ListTile(
                title: Text(week),
                subtitle: Text('$duration minutes'),
              );
            },
          ),
        ),
      ],
    );
  }
}
