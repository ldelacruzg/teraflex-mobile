class TreatmentTask {
  final AssignedTask task;
  final TaskConfig setting;

  TreatmentTask({required this.task, required this.setting});
}

class AssignedTask {
  final int id;
  final String title;
  final String description;
  final DateTime assignmentDate;
  final DateTime? performancedDate;
  final DateTime expirationDate;

  AssignedTask({
    required this.id,
    required this.title,
    required this.description,
    required this.assignmentDate,
    this.performancedDate,
    required this.expirationDate,
  });
}

class TaskConfig {
  final double timePerRepetition;
  final int repetitions;
  final double breakTime;
  final int series;

  TaskConfig({
    required this.timePerRepetition,
    required this.repetitions,
    required this.breakTime,
    required this.series,
  });
}
