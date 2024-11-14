import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  bool _isLoading = false;

  late Future<List<Task>> _futureTasks;
  late TaskService _taskService;
  late int _totalTasksChecked = 0;
  late int _totalTasks = 0;

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

  int _getTotalTasksChecked(List<Task> tasks) {
    return tasks.where((task) => task.isChecked).length;
  }

  void _loadTasks(DateTime date) {
    setState(() {
      _futureTasks = _taskService.tasks(date.toString());
    });

    // Refresh task checked
    _futureTasks.then((tasks) {
      setState(() {
        _totalTasksChecked = _getTotalTasksChecked(tasks);
        _totalTasks = tasks.length;
      });
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
            order: tasks.length,
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

  Future<void> _handleUpdateTask(Task task) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _taskService.updateTask(task);
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

  Future<void> _handleDeleteTask(Task task) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _taskService.deleteTask(task.id);
      _loadTasks(task.date);
      MessageService.showSuccesMessage(context, 'Tâche supprimée avec succès');
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
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '$_totalTasksChecked/$_totalTasks Tâches (max 4)',
            style: const TextStyle(
              fontSize: 24.0, // Taille de la police pour le titre
              fontWeight: FontWeight.bold, // Mettre le texte en gras
            ),
          ),
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
                                    Dismissible(
                                      direction: DismissDirection.endToStart,
                                      key: Key(task.id),
                                      onDismissed: (direction) {
                                        _handleDeleteTask(task);
                                      },
                                      background: Container(
                                        decoration: ShapeDecoration(
                                          color: Color(0xFFE95569),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16.0),
                                            child: SvgPicture.asset(
                                              'assets/icons/trash.svg',
                                              colorFilter: ColorFilter.mode(
                                                  Colors.white,
                                                  BlendMode.srcIn),
                                              width: 24,
                                              height: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: TaskCard(
                                          task: task,
                                          onCreateTask: _handleCreateTask,
                                          onUpdateTask: _handleUpdateTask,
                                          onCheckTask: _handleCheckTask),
                                    ),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    onPressed: _addTask,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      '+',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontFamily:
                            'Londrina', // Taille de la police pour le titre
                      ),
                    ),
                  ),
                ),
              ]),
      ],
    );
  }
}
