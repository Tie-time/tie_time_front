import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environnement {
  static String get apiUrl => dotenv.env['API_BASE_URL'] ?? '';
}
