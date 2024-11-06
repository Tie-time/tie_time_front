import 'package:flutter/material.dart';
import 'package:tie_time_front/models/task.model.dart';
import 'package:tie_time_front/widgets/cards/task.card.dart';

class TasksList extends StatefulWidget {
  final DateTime currentDate;

  const TasksList({super.key, required this.currentDate});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  // fetch tasks by date
  // add tasks with date
  late List<Task> _tasks;
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    _tasks = [
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
    ];
    _currentDate = widget.currentDate;
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
    return Column(
      children: [
        const Text(
          'Listes tâches',
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 16.0),
        Column(
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
        FilledButton(
          onPressed: _addTask,
          child: const Text('+'),
        ),
      ],
    );
  }
}
