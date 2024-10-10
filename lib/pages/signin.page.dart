import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          FilledButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
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
