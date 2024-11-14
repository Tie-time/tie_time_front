import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tie_time_front/widgets/app-bar/date.app-bar.dart';
import 'package:tie_time_front/widgets/lists/tasks.list.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ValueNotifier<DateTime> _currentDateNotifier;

  @override
  void initState() {
    super.initState();
    _currentDateNotifier = ValueNotifier<DateTime>(DateTime.now());
    initializeDateFormatting('fr_FR', null).then((_) {
      setState(() {});
    });
  }

  void _addDay() {
    setState(() {
      _currentDateNotifier.value =
          _currentDateNotifier.value.add(Duration(days: 1));
    });
  }

  void _removeDay() {
    setState(() {
      _currentDateNotifier.value =
          _currentDateNotifier.value.subtract(Duration(days: 1));
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _currentDateNotifier.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('fr', 'FR'),
    );
    if (picked != null && picked != _currentDateNotifier.value) {
      setState(() {
        _currentDateNotifier.value = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DateAppBar(
          currentDate: _currentDateNotifier.value,
          onRemoveDay: _removeDay,
          onAddDay: _addDay,
          onSelectDate: _selectDate),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TasksList(
                currentDateNotifier: _currentDateNotifier,
              )
            ],
          ),
        ),
      ),
    );
  }
}
