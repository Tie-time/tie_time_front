import 'package:flutter/material.dart';
import 'package:tie_time_front/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Theme
      theme: ThemeData(
          // Text
          textTheme: TextTheme(
              bodyMedium: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF2D3A3E))),
          // Body / Scaffold
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          // Inputs
          inputDecorationTheme: InputDecorationTheme(
              contentPadding: EdgeInsets.all(16.0),
              filled: true,
              fillColor: const Color(0xFFFFFFFF),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: Color(0xFFBFBEBE),
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: Color(0xFF2E7984),
                  width: 2.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: Color(0xFFE95569),
                  width: 2.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  color: Color(0xFFE95569),
                  width: 2.0,
                ),
              ),
              labelStyle: TextStyle(color: Color(0xFFBFBEBE), fontSize: 20.0),
              errorStyle: TextStyle(color: Color(0xFFE95569))),
          // Buttons
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
                backgroundColor: Color(0xFF2E7984),
                minimumSize: const Size(double.infinity),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                textStyle:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),
          // Snackbar
          snackBarTheme: SnackBarThemeData(
              backgroundColor: Color(0xFFE95569),
              contentTextStyle:
                  TextStyle(fontSize: 16.0, color: Color(0xFFFFFFFF)))),
      initialRoute: RouteManager.home,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
