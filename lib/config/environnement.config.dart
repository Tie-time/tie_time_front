import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environnement {
  static String get apiUrl => dotenv.env['API_BASE_URL'] ?? '';
  static String get androidDevStaticFileBaseUrl =>
      dotenv.env['ANDROID_DEV_STATIC_FILE_BASE_URL'] ?? '';
  static String get devStaticFileBaseUrl =>
      dotenv.env['DEV_STATIC_FILE_BASE_URL'] ?? '';

  static String getStaticFileBaseUrl(String path) {
    if (Platform.isAndroid) {
      return '$androidDevStaticFileBaseUrl$path';
    } else if (Platform.isIOS) {
      return '$devStaticFileBaseUrl$path';
    }

    return '$devStaticFileBaseUrl$path';
  }
}
