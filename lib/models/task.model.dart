class Task {
  final String id;
  final String title;
  final bool isChecked;
  final DateTime date;
  final int order;

  const Task({
    required this.id,
    required this.title,
    required this.isChecked,
    required this.date,
    required this.order,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    try {
      return Task(
        id: json['id'] as String,
        title: json['title'] as String,
        isChecked: json['is_checked'] as bool,
        date: json['date'] as DateTime,
        order: json['order'] as int,
      );
    } catch (e) {
      throw FormatException('Failed to load Task: $e');
    }
  }
}
