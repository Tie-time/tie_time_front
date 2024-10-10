import 'package:flutter/material.dart';
import 'package:tie_time_front/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: RouteManager.home,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
