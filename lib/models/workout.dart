class Workout{
  final String id;
  final String name;
  final String type; // new field for workout type
  final DateTime date;
  final int duration; //in minutes
  final int caloriesBurned;

  Workout({
    required this.id,
    required this.name,
    required this.type,
    required this.date,
    required this.duration,
    required this.caloriesBurned
});

}