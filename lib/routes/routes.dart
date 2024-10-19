import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tie_time_front/pages/analyse.page.dart';
import 'package:tie_time_front/pages/signin.page.dart';
import 'package:tie_time_front/pages/signup.page.dart';
import 'package:tie_time_front/widgets/navigations/main.navigation.dart';

class RouteManager {
  static const String home = '/';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String analyse = '/analyse';
  static const String configuration = '/configuration';
  static const String account = '/account';

  static Future<bool> _isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _buildAuthRoute(const MainNavigation());
      case signin:
        return MaterialPageRoute(builder: (_) => const SigninPage());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case analyse:
        return _buildAuthRoute(const AnalysePage());
      case configuration:
        return _buildAuthRoute(const MainNavigation());
      case account:
        return _buildAuthRoute(const MainNavigation());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute _buildAuthRoute(Widget page) {
    return MaterialPageRoute(
      builder: (_) => FutureBuilder<bool>(
        future: _isAuthenticated(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasData && snapshot.data == true) {
            return page;
          } else {
            return const SigninPage();
          }
        },
      ),
    );
  }
}
