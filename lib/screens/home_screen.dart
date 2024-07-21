import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workouts.dart';
import '../screens/add_workout_screen.dart';
import '../screens/summary_screen.dart';
import '../screens/goals_screen.dart';  // Import the new screen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => DefaultTabController(
                  length: 2,
                  child: SummaryScreen(),
                ),
              ));
            },
          ),
          IconButton(
            icon: Icon(Icons.flag),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => GoalsScreen(),
              ));
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<WorkoutsProvider>(context, listen: false).loadWorkouts(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<WorkoutsProvider>(
          builder: (ctx, workoutsProvider, child) => ListView.builder(
            itemCount: workoutsProvider.workouts.length,
            itemBuilder: (ctx, index) {
              final workout = workoutsProvider.workouts[index];
              return ListTile(
                title: Text(workout.name),
                subtitle: Text(
                  '${workout.type}, ${workout.duration} mins, ${workout.caloriesBurned} cal',
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    workoutsProvider.removeWorkout(workout.id);
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => AddWorkoutScreen(),
          ));
        },
      ),
    );
  }
}
