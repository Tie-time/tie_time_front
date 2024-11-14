import 'package:flutter/material.dart';
import 'package:tie_time_front/routes/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await dotenv.load(fileName: "dev.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Theme
      theme: ThemeData(
          // Appbar theme
          appBarTheme: AppBarTheme(
              centerTitle: true,
              toolbarHeight: 100.0,
              titleTextStyle: TextStyle(
                  fontFamily: "Londrina",
                  fontSize: 56,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF2E7984))),
          // Color shema
          colorScheme: ColorScheme.light(
            primary: Color(0xFF2E7984),
            secondary: Color(0xFFF8A980),
            tertiary: Color(0xFFE95569),
            surface: Color(0xFFFFFFFF),
            error: Color(0xFFE95569),
            onPrimary: Color(0xFFFFFFFF),
            onSecondary: Color(0xFFFFFFFF),
            onTertiary: Color(0xFFFFFFFF),
            onSurface: Color(0xFF2D3A3E),
            onError: Color(0xFFFFFFFF),
          ),
          // Text
          textTheme: TextTheme(
              bodyMedium: TextStyle(
                  fontFamily: "Inter",
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
          // Inputs
          checkboxTheme: CheckboxThemeData(
            side: BorderSide(
              color: Color(0xFFBFBEBE),
              width: 2.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          // Cards
          cardTheme: CardTheme(margin: EdgeInsets.all(0.0)),
          // Buttons
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
                backgroundColor: Color(0xFF2E7984),
                minimumSize: const Size(double.infinity, 0),
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
                  TextStyle(fontSize: 16.0, color: Color(0xFFFFFFFF))),
          // Navigation
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            unselectedItemColor: Color(0xFFBFBEBE),
          )),
      initialRoute: RouteManager.home,
      onGenerateRoute: RouteManager.generateRoute,
      // Localisation delegate for date
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('fr', 'FR'),
      ],
    );
  }
}
