import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tie_time_front/widgets/app-bar/date.app-bar.dart';
import 'package:tie_time_front/widgets/cards/task.card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // fetch tasks by date
  // add tasks with date
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    initializeDateFormatting('fr_FR', null).then((_) {
      setState(() {});
    });
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
    return Scaffold(
        appBar: DateAppBar(
            currentDate: _currentDate,
            onRemoveDay: _removeDay,
            onAddDay: _addDay,
            onSelectDate: _selectDate),
        body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  Text('Listes tâches'),
                  TaskCard(title: 'Tâche 1'),
                ])))));
  }
}
