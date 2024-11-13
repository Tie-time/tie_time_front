import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tie_time_front/config/environnement.config.dart';
import 'package:tie_time_front/models/task.model.dart';
import 'package:tie_time_front/services/api.service.dart';
import 'package:tie_time_front/services/messages.service.dart';
import 'package:tie_time_front/services/task.service.dart';
import 'package:tie_time_front/widgets/cards/task.card.dart';

class TasksList extends StatefulWidget {
  final ValueNotifier<DateTime> currentDateNotifier;

  const TasksList({super.key, required this.currentDateNotifier});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  // fetch tasks by date
  // add tasks with date
  final List<Task> _tasks = [];
  bool _isLoading = false;

  late Future<List<Task>> _futureTasks;
  late TaskService _taskService;

  @override
  void initState() {
    super.initState();
    _taskService =
        TaskService(apiService: ApiService(baseUrl: Environnement.apiUrl));
    _loadTasks(widget.currentDateNotifier.value);
    // Listen to changes on the current date
    widget.currentDateNotifier.addListener(() {
      _loadTasks(widget.currentDateNotifier.value);
    });
  }

  void _loadTasks(DateTime date) {
    setState(() {
      _futureTasks = _taskService.tasks(date.toString());
    });
  }

  void _addTask() {
    setState(() {
      _futureTasks.then((tasks) {
        tasks.add(Task(
            id: UniqueKey().toString(),
            title: '',
            isChecked: false,
            date: widget.currentDateNotifier.value,
            order: _tasks.length,
            isEditing: true));
      });
    });
  }

  Future<void> _handleCreateTask(Task task) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _taskService.createTask(task);
      _loadTasks(task.date);
    } catch (e) {
      MessageService.showErrorMessage(context, '$e');
    } finally {
      _loadTasks(task.date);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleCheckTask(Task task) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _taskService.checkTask(task.id);
      _loadTasks(task.date);
    } catch (e) {
      MessageService.showErrorMessage(context, '$e');
    } finally {
      _loadTasks(task.date);
      setState(() {
        _isLoading = false;
      });
    }
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
        _isLoading
            ? const CircularProgressIndicator()
            : Column(children: [
                FutureBuilder<List<Task>>(
                  future: _futureTasks,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final tasks = snapshot.data!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: tasks
                            .map((task) => Column(
                                  children: [
                                    TaskCard(
                                        task: task,
                                        onCreateTask: _handleCreateTask,
                                        onCheckTask: _handleCheckTask),
                                    SizedBox(
                                        height:
                                            16.0), // Espace entre les éléments
                                  ],
                                ))
                            .toList(),
                      );
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
                  onPressed: _addTask,
                  child: const Text('+'),
                ),
              ]),
      ],
    );
  }
}
