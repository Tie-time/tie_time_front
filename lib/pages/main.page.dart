import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tie_time_front/config/environnement.config.dart';
import 'package:tie_time_front/models/user.model.dart';
import 'package:tie_time_front/routes/routes.dart';
import 'package:tie_time_front/services/api.service.dart';
import 'package:tie_time_front/services/auth.service.dart';
import 'package:tie_time_front/services/messages.service.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<User> _futureUser;
  late AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService =
        AuthService(apiService: ApiService(baseUrl: Environnement.apiUrl));
    _futureUser = _authService.me();
    initializeDateFormatting('fr_FR', null).then((_) {
      setState(() {});
    });
  }

  void _handleLogout() async {
    // clear cache
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacementNamed(context, RouteManager.home);
  }

  @override
  Widget build(BuildContext context) {
    // Obtenir la date actuelle et la formater
    String formattedDate =
        DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(DateTime.now());

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(formattedDate),
        ),
        body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  FutureBuilder<User>(
                    future: _futureUser,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!.email);
                      } else if (snapshot.hasError) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          MessageService.showErrorMessage(
                              context, snapshot.error.toString());
                        });
                        return Container();
                      }
                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                  FilledButton(
                    onPressed: () {
                      _handleLogout();
                    },
                    child: Text('Se déconnecter'),
                  ),
                ])))));
  }
}
