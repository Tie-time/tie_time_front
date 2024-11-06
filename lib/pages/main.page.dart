import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tie_time_front/models/task.model.dart';
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
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Tâche 1',
      isChecked: false,
      date: DateTime.now(),
      order: 1,
    ),
    Task(
      id: '2',
      title: 'Tâche 2',
      isChecked: false,
      date: DateTime.now(),
      order: 2,
    ),
    Task(
      id: '3',
      title: 'Tâche 3',
      isChecked: false,
      date: DateTime.now(),
      order: 3,
    ),
  ]; // Liste des tâches

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

  void _addTask() {
    setState(() {
      _tasks.add(Task(
          id: UniqueKey().toString(),
          title: '',
          isChecked: false,
          date: _currentDate,
          order: _tasks.length,
          isEditing: true));
    });
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
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              'Listes tâches',
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 16.0),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _tasks
                    .map((task) => Column(
                          children: [
                            TaskCard(task: task),
                            SizedBox(height: 16.0), // Espace entre les éléments
                          ],
                        ))
                    .toList(),
              ),
            ),
            FilledButton(
              onPressed: _addTask,
              child: const Text('+'),
            ), // Boucle pour afficher les tâches
          ]),
        ),
      ),
    );
  }
}
