import 'package:flutter/material.dart';

class SigninForm extends StatefulWidget {
  final Function(String email, String password) onSignIn;
  final bool isLoading;

  const SigninForm({
    super.key,
    required this.onSignIn,
    required this.isLoading,
  });

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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

  void _handleSignIn() {
    if (_formKey.currentState?.validate() != false) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      widget.onSignIn(email, password);
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
          widget.isLoading
              ? const CircularProgressIndicator()
              : FilledButton(
                  onPressed: _handleSignIn,
                  child: const Text('Se connecter'),
                ),
        ],
      ),
    );
  }
}
