class SimpleTreatment {
  final int id;
  final String title;
  final int numberTasks;
  final int completedTasks;
  final int pendingTasks;

  SimpleTreatment({
    required this.id,
    required this.title,
    required this.numberTasks,
    required this.completedTasks,
    required this.pendingTasks,
  });

  toObjet() {
    return {
      'id': id,
      'title': title,
      'numberTasks': numberTasks,
      'completedTasks': completedTasks,
      'pendingTasks': pendingTasks,
    };
  }
}
