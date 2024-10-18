class Role {
  final int id;
  final String label;

  const Role({
    required this.id,
    required this.label,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    try {
      return Role(
        id: json['id'] as int,
        label: json['label'] as String,
      );
    } catch (e) {
      throw FormatException('Failed to load Role: $e');
    }
  }
}
