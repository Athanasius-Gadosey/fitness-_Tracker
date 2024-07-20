import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workouts.dart';
import '../screens/add_workout_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Tracker'),
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
                  '${workout.duration} mins, ${workout.caloriesBurned} cal',
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
