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
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    _authService =
        AuthService(apiService: ApiService(baseUrl: Environnement.apiUrl));
    _futureUser = _authService.me();
    _currentDate = DateTime.now();
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

  void _addDay() {
    setState(() {
      _currentDate = _currentDate.add(Duration(days: 1));
    });
  }

  void _removeDay() {
    setState(() {
      _currentDate = _currentDate.subtract(Duration(days: 1));
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('fr', 'FR'),
    );
    if (picked != null && picked != _currentDate) {
      setState(() {
        _currentDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtenir la date actuelle et la formater
    String formattedDate =
        DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(_currentDate);

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
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addDay,
                    child: Text('Ajouter un jour'),
                  ),
                  ElevatedButton(
                    onPressed: _removeDay,
                    child: Text('Enlever un jour'),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Choisir une date'),
                  ),
                ])))));
  }
}
