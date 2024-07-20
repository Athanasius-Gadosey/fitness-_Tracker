import 'package:flutter/material.dart';
import '../models/workout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WorkoutsProvider with ChangeNotifier {
  List<Workout> _workouts = [];

  List<Workout> get workouts => [..._workouts];

  Future<void> addWorkout(Workout workout) async {
    _workouts.add(workout);
    notifyListeners();
    await _saveToPrefs();
  }

  Future<void> removeWorkout(String id) async {
    _workouts.removeWhere((workout) => workout.id == id);
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
        date: DateTime.parse(item['date']),
        duration: item['duration'],
        caloriesBurned: item['caloriesBurned'],
      ))
          .toList();
      notifyListeners();
    }
  }

  Future<void> _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('workouts', json.encode(_workouts));
  }
}
