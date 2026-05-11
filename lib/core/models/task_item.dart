class TaskItem {
  final String id;
  final String title;
  final String? description;
  final String? assignedTo;
  final bool isCompleted;
  final DateTime? dueDate;

  TaskItem({
    required this.id,
    required this.title,
    this.description,
    this.assignedTo,
    required this.isCompleted,
    this.dueDate,
  });
}