import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workouts.dart';
import 'add_goal_screen.dart';

class GoalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Goals'),
      ),
      body: Consumer<WorkoutsProvider>(
        builder: (ctx, workoutsProvider, child) => ListView.builder(
          itemCount: workoutsProvider.goals.length,
          itemBuilder: (ctx, index) {
            final goal = workoutsProvider.goals[index];
            return ListTile(
              title: Text(goal.name),
              subtitle: Text(
                'Target: ${goal.targetDuration} mins, Progress: ${goal.currentDuration} mins',
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  workoutsProvider.removeGoal(goal.id);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => AddGoalScreen(),
          ));
        },
      ),
    );
  }
}
