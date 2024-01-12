class Treatment {
  final int id;
  final String title;
  final String description;
  final bool isActive;
  final DateTime startDate;
  final DateTime? endDate;

  Treatment({
    required this.id,
    required this.title,
    required this.description,
    required this.isActive,
    required this.startDate,
    required this.endDate,
  });
}
