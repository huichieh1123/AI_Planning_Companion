class TaskModel {
  final String id;
  final String title;
  final String? subtitle;
  final String? assignee;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    this.subtitle,
    this.assignee,
    this.isCompleted = false,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? assignee,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      assignee: assignee ?? this.assignee,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // Future conversion methods from/to JSON (for API)
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      assignee: json['assignee'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'assignee': assignee,
      'isCompleted': isCompleted,
    };
  }
}
