import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          FilledButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, '/');
              },
              child: const Text('S’inscrire')),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/signin');
            },
            //unline text
            child: const Text('Déjà un compte ? Clique ici pour te connecter !',
                style: TextStyle(decoration: TextDecoration.underline)),
          ),
        ],
      )),
    );
  }
}
