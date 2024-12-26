class Rate {
  final String? id;
  final int typeRate;
  final String label;
  final int outOf;
  final double? score;
  final bool isEditing;

  const Rate(
      {this.id,
      required this.typeRate,
      required this.label,
      required this.outOf,
      this.score,
      this.isEditing = false});

  factory Rate.fromJson(Map<String, dynamic> json) {
    try {
      return Rate(
        id: json['id'] != null ? (json['id'] as String) : null,
        label: json['label'] as String,
        outOf: json['out_of'] as int,
        typeRate: json['type_rate_id'] as int,
        score: json['score'] != null ? json['score'] as double : null,
      );
    } catch (e) {
      throw FormatException('Failed to load Rate: $e');
    }
  }

  Rate copyWith(
      {String? id,
      String? label,
      double? score,
      int? outOf,
      int? typeRate,
      bool? isEditing}) {
    return Rate(
      id: id ?? this.id,
      typeRate: typeRate ?? this.typeRate,
      label: label ?? this.label,
      score: score ?? this.score,
      outOf: outOf ?? this.outOf,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}
