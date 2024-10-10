import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tie_time_front/routes/routes.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signIn(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
            'http://10.0.2.2:5001/api/users/signin'), // Remplacez par votre URL API
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String token = data['token'];

        // Stocker le token
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        // Naviguer vers la page principale
        Navigator.pushReplacementNamed(context, RouteManager.home);
      } else {
        var error = jsonDecode(response.body);
        _showMessage(
            'Échec de la connexion: ${error['message'] ?? 'Erreur inconnue'}');
      }
    } catch (e) {
      _showMessage('Une erreur est survenue: $e');
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

  void _handleSignIn() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Veuillez remplir tous les champs.');
      return;
    }

    _signIn(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Mot de passe',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16.0),
          _isLoading
              ? const CircularProgressIndicator()
              : FilledButton(
                  onPressed: () {
                    _handleSignIn();
                  },
                  child: const Text('Se connecter')),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: const Text(
                'Pas encore de compte ? Clique ici pour en créer un !',
                style: TextStyle(decoration: TextDecoration.underline)),
          ),
        ],
      )),
    );
  }
}
