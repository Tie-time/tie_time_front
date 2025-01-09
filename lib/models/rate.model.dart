class Rate {
  final String id;
  final String label;
  final String description;
  final int outOf;
  final int score;
  final int typeRate;
  final bool isEditing;
  final bool isShowingDescription;

  const Rate(
      {required this.id,
      required this.label,
      required this.description,
      required this.outOf,
      required this.score,
      required this.typeRate,
      this.isEditing = false,
      this.isShowingDescription = false});

  factory Rate.fromJson(Map<String, dynamic> json) {
    try {
      return Rate(
        id: json['id'] != null ? (json['id'] as String) : '',
        label: json['label'] as String,
        description: json['description'] as String,
        outOf: json['out_of'] as int,
        typeRate: json['type_rate_id'] as int,
        score: json['score'] != null ? json['score'] as int : 0,
      );
    } catch (e) {
      throw FormatException('Failed to load Rate: $e');
    }
  }

  Rate copyWith(
      {String? id,
      String? label,
      String? description,
      int? score,
      int? outOf,
      int? typeRate,
      bool? isEditing,
      bool? isShowingDescription}) {
    return Rate(
      id: id ?? this.id,
      label: label ?? this.label,
      description: description ?? this.description,
      score: score ?? this.score,
      outOf: outOf ?? this.outOf,
      typeRate: typeRate ?? this.typeRate,
      isEditing: isEditing ?? this.isEditing,
      isShowingDescription: isShowingDescription ?? this.isShowingDescription,
    );
  }
}
