import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/workouts.dart';
import './screens/home_screen.dart';
import './screens/summary_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => WorkoutsProvider(),
      child: MaterialApp(
        title: 'Fitness Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DefaultTabController(
          length: 2,
          child: HomeScreen(),
        ),
      ),
    );
  }
}
