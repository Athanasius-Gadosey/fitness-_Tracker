class Goal {
  final String id;
  final String name;
  final int targetDuration; // in minutes
  final int currentDuration; // in minutes

  Goal({
    required this.id,
    required this.name,
    required this.targetDuration,
    required this.currentDuration,
  });
}
