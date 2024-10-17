import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tie_time_front/routes/routes.dart';
import 'package:tie_time_front/services/api.service.dart';
import 'package:tie_time_front/services/auth.service.dart';
import 'package:tie_time_front/widgets/forms/signin.forms.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool _isLoading = false;
  late AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService = AuthService(
        apiService: ApiService(baseUrl: 'http://10.0.2.2:5001/api/users'));
  }

  Future<void> _signIn(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    try {
      var data = await _authService.signin(email, password);

      // final response = await http.post(
      //   Uri.parse('http://10.0.2.2:5001/api/users/signin'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode({'email': email, 'password': password}),
      // );

      String token = data['token'];

      // Stocker le token
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      // Naviguer vers la page principale
      Navigator.pushReplacementNamed(context, RouteManager.home);
    } catch (e) {
      _showMessage('$e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
                child: SingleChildScrollView(
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 580.0,
                        ), // Définir la hauteur minimale de la colonne
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/logo.svg',
                                height: 120,
                              ),
                              const SizedBox(height: 64.0),
                              SigninForm(
                                onSignIn: _signIn,
                                isLoading: _isLoading,
                              ),
                              const SizedBox(height: 24.0),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                                child: const Text(
                                    'Pas encore de compte ? Clique ici pour en créer un !',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline)),
                              ),
                            ]))))));
  }
}
