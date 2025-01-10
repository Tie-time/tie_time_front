class Settings {
  final int maxTasks;
  final List<PassionSettings> passions;

  const Settings({
    required this.maxTasks,
    required this.passions,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      maxTasks: json['maxTasks'] as int,
      passions: (json['passions'] as List<dynamic>)
          .map((e) => PassionSettings.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'maxTasks': maxTasks,
        'passions': passions.map((e) => e.toJson()).toList(),
      };

  Settings copyWith({
    int? maxTasks,
    List<PassionSettings>? passions,
  }) {
    return Settings(
      maxTasks: maxTasks ?? this.maxTasks,
      passions: passions ?? this.passions,
    );
  }
}

class PassionSettings {
  final String id;
  final String name;
  final bool isSelected;

  const PassionSettings({
    required this.id,
    required this.name,
    required this.isSelected,
  });

  PassionSettings copyWith({
    String? id,
    String? name,
    bool? isSelected,
  }) {
    return PassionSettings(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory PassionSettings.fromJson(Map<String, dynamic> json) {
    return PassionSettings(
      id: json['id'] as String,
      name: json['name'] as String,
      isSelected: json['isSelected'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'isSelected': isSelected,
      };
}
