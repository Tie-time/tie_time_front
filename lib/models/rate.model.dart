class Rate {
  final String? id;
  final String label;
  final int outOf;
  final double score;
  final int typeRate;
  final bool isEditing;

  const Rate(
      {this.id,
      required this.label,
      required this.outOf,
      required this.score,
      required this.typeRate,
      this.isEditing = false});

  factory Rate.fromJson(Map<String, dynamic> json) {
    try {
      return Rate(
        id: json['id'] != null ? (json['id'] as String) : null,
        label: json['label'] as String,
        outOf: json['out_of'] as int,
        typeRate: json['type_rate_id'] as int,
        score: json['score'] != null ? json['score'] as double : 0,
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
      label: label ?? this.label,
      score: score ?? this.score,
      outOf: outOf ?? this.outOf,
      typeRate: typeRate ?? this.typeRate,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}
