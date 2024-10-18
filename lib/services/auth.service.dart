import 'package:tie_time_front/models/user.model.dart';
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

  Future<User> me() async {
    Map<String, dynamic> responseBody = await apiService.get('$prefix/me');
    return User.fromJson(responseBody);
  }
}
