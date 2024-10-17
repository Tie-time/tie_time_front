import 'package:tie_time_front/services/api.service.dart';

class AuthService {
  final ApiService apiService;
  final String prefix = '/users';

  AuthService({required this.apiService});

  Future<Map<String, dynamic>> signup(
      String email, String password, String pseudo) async {
    return await apiService.post('$prefix/signup', {
      'email': email,
      'password': password,
      'pseudo': pseudo,
    });
  }

  Future<Map<String, dynamic>> signin(String email, String password) async {
    return await apiService.post('$prefix/signin', {
      'email': email,
      'password': password,
    });
  }
}
