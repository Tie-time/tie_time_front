import 'package:tie_time_front/config/environnement.config.dart';

class Passion {
  final int id;
  final String label;
  final String iconPath;
  final bool isChecked;

  const Passion({
    required this.id,
    required this.label,
    required this.iconPath,
    required this.isChecked,
  });

  String get iconUrl {
    return Environnement.getStaticFileBaseUrl(iconPath);
  }

  factory Passion.fromJson(Map<String, dynamic> json) {
    try {
      return Passion(
        id: json['id'] as int,
        label: json['label'] as String,
        iconPath: json['icon_path'] as String,
        isChecked: json['is_checked'] as bool,
      );
    } catch (e) {
      throw FormatException('Failed to load Passion: $e');
    }
  }

  Passion copyWith({
    int? id,
    String? label,
    String? iconPath,
    bool? isChecked,
  }) {
    return Passion(
      id: id ?? this.id,
      label: label ?? this.label,
      iconPath: iconPath ?? this.iconPath,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
