import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  final Function(String email, String password, String pseudo) onSignUp;
  final bool isLoading;

  const SignupForm({
    super.key,
    required this.onSignUp,
    required this.isLoading,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pseudoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Veuillez entrer un email valide';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre mot de passe';
    }
    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    return null;
  }

  String? _validatePseudo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un pseudo mot de passe';
    }
    if (value.length < 4) {
      return 'Le pseudo doit contenir au moins 4 caractères';
    }
    return null;
  }

  void _handleSignUp() {
    if (_formKey.currentState?.validate() != false) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String pseudo = _pseudoController.text.trim();
      widget.onSignUp(email, password, pseudo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
            style: TextStyle(fontSize: 20.0, color: Color(0xFF2D3A3E)),
          ),
          const SizedBox(height: 24.0),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Mot de passe',
            ),
            obscureText: true,
            validator: _validatePassword,
            style: TextStyle(fontSize: 20.0, color: Color(0xFF2D3A3E)),
          ),
          const SizedBox(height: 24.0),
          TextFormField(
            controller: _pseudoController,
            decoration: const InputDecoration(
              labelText: 'Pseudo',
            ),
            validator: _validatePseudo,
            style: TextStyle(fontSize: 20.0, color: Color(0xFF2D3A3E)),
          ),
          const SizedBox(height: 24.0),
          widget.isLoading
              ? const CircularProgressIndicator()
              : FilledButton(
                  onPressed: _handleSignUp,
                  child: const Text('S\'inscrire'),
                ),
        ],
      ),
    );
  }
}
