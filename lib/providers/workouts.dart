import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../models/goal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WorkoutsProvider with ChangeNotifier {
  List<Workout> _workouts = [];
  List<Goal> _goals = [];

  List<Workout> get workouts => [..._workouts];
  List<Goal> get goals => [..._goals];

  Future<void> addWorkout(Workout workout) async {
    _workouts.add(workout);
    notifyListeners();
    await _saveToPrefs();

    // Update of goals
    for (var goal in _goals) {
      if (goal.name == workout.name) {
        await updateGoal(goal.id, goal.currentDuration + workout.duration);
      }
    }
  }

  Future<void> removeWorkout(String id) async {
    _workouts.removeWhere((workout) => workout.id == id);
    notifyListeners();
    await _saveToPrefs();
  }

  Future<void> addGoal(Goal goal) async {
    _goals.add(goal);
    notifyListeners();
    await _saveToPrefs();
  }

  Future<void> updateGoal(String id, int currentDuration) async {
    final goalIndex = _goals.indexWhere((goal) => goal.id == id);
    if (goalIndex >= 0) {
      _goals[goalIndex] = Goal(
        id: _goals[goalIndex].id,
        name: _goals[goalIndex].name,
        targetDuration: _goals[goalIndex].targetDuration,
        currentDuration: currentDuration,
      );
      notifyListeners();
      await _saveToPrefs();
    }
  }

  Future<void> removeGoal(String id) async {
    _goals.removeWhere((goal) => goal.id == id);
    notifyListeners();
    await _saveToPrefs();
  }

  Future<void> loadWorkouts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('workouts');
    if (data != null) {
      _workouts = (json.decode(data) as List)
          .map((item) => Workout(
        id: item['id'],
        name: item['name'],
        type: item['type'],
        date: DateTime.parse(item['date']),
        duration: item['duration'],
        caloriesBurned: item['caloriesBurned'],
      ))
          .toList();
      notifyListeners();
    }
    String? goalData = prefs.getString('goals');
    if (goalData != null) {
      _goals = (json.decode(goalData) as List)
          .map((item) => Goal(
        id: item['id'],
        name: item['name'],
        targetDuration: item['targetDuration'],
        currentDuration: item['currentDuration'],
      ))
          .toList();
      notifyListeners();
    }
  }

  Future<void> _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('workouts', json.encode(_workouts));
    prefs.setString('goals', json.encode(_goals));
  }

  Map<String, int> get dailySummary {
    Map<String, int> summary = {};
    _workouts.forEach((workout) {
      String date = workout.date.toIso8601String().split('T')[0];
      if (summary.containsKey(date)) {
        summary[date] = summary[date]! + workout.duration;
      } else {
        summary[date] = workout.duration;
      }
    });
    return summary;
  }

  Map<String, int> get weeklySummary {
    Map<String, int> summary = {};
    _workouts.forEach((workout) {
      int week = workout.date.difference(DateTime(1970, 1, 1)).inDays ~/ 7;
      String weekKey = '${workout.date.year}-W${week}';
      if (summary.containsKey(weekKey)) {
        summary[weekKey] = summary[weekKey]! + workout.duration;
      } else {
        summary[weekKey] = workout.duration;
      }
    });
    return summary;
  }
}
