import 'package:tie_time_front/models/role.model.dart';

class User {
  final String id;
  final String email;
  final String pseudo;
  final Role role;

  const User({
    required this.id,
    required this.email,
    required this.pseudo,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
        id: json['id'] as String,
        email: json['email'] as String,
        pseudo: json['pseudo'] as String,
        role: Role.fromJson(json['role'] as Map<String, dynamic>),
      );
    } catch (e) {
      throw FormatException('Failed to load User: $e');
    }
  }
}
