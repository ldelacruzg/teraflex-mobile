class LeaderboardRow {
  final int patientId;
  final String firstName;
  final String lastName;
  final int qtyTasks;
  final int qtyTasksCompleted;
  final double accuracy;

  LeaderboardRow({
    required this.patientId,
    required this.firstName,
    required this.lastName,
    required this.qtyTasks,
    required this.qtyTasksCompleted,
    required this.accuracy,
  });
}
