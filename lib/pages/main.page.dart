import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tie_time_front/routes/routes.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _handleLogout() async {
    // clear cache
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacementNamed(context, RouteManager.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Tie Time'),
        ),
        body: Center(
            child: Column(children: [
          Text('Welcome to Tie Time!'),
          FilledButton(
              onPressed: () {
                _handleLogout();
              },
              child: Text('Se déconnecter')),
        ])));
  }
}
