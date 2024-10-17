import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:tie_time_front/routes/routes.dart';
import 'package:tie_time_front/widgets/forms/signup.form.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isLoading = false;

  Future<void> _signup(String email, String password, String pseudo) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5001/api/users/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'email': email, 'password': password, 'pseudo': pseudo}),
      );

      if (response.statusCode != 201) {
        var result = jsonDecode(response.body);
        var message = result['error'];
        throw Exception(message);
      }

      var data = jsonDecode(response.body);
      // Naviguer vers la page principale
      Navigator.pushReplacementNamed(context, RouteManager.signin);

      _showMessage(data['success']);
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
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/logo.svg',
                                height: 120,
                              ),
                              const SizedBox(height: 64.0),
                              SignupForm(
                                onSignUp: _signup,
                                isLoading: _isLoading,
                              ),
                              const SizedBox(height: 24.0),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/signin');
                                },
                                //unline text
                                child: const Text(
                                    'Déjà un compte ? Clique ici pour te connecter !',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline)),
                              ),
                            ]))))));
  }
}
