class Passion {
  final int id;
  final String label;
  final String iconsUrl;
  final bool isChecked;

  const Passion({
    required this.id,
    required this.label,
    required this.iconsUrl,
    required this.isChecked,
  });

  factory Passion.fromJson(Map<String, dynamic> json) {
    try {
      return Passion(
        id: json['id'] as int,
        label: json['label'] as String,
        iconsUrl: json['icon_url'] as String,
        isChecked: json['is_checked'] as bool,
      );
    } catch (e) {
      throw FormatException('Failed to load Passion: $e');
    }
  }

  Passion copyWith({
    int? id,
    String? label,
    String? iconsUrl,
    bool? isChecked,
  }) {
    return Passion(
      id: id ?? this.id,
      label: label ?? this.label,
      iconsUrl: iconsUrl ?? this.iconsUrl,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
