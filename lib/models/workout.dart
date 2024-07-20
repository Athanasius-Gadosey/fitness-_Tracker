class Workout{
  final String id;
  final String name;
  final DateTime date;
  final int duration; //in minutes
  final int caloriesBurned;

  Workout({
    required this.id,
    required this.name,
    required this.date,
    required this.duration,
    required this.caloriesBurned
});

}