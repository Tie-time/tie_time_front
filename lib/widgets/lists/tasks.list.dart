import 'package:flutter/material.dart';
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

  void _onEditingNewTask() {
    setState(() {
      _futureTasks.then((tasks) {
        tasks.add(Task(
            id: '',
            title: '',
            isChecked: false,
            date: widget.currentDateNotifier.value,
            order: tasks.length,
            isEditing: true));
      });
    });
  }

  void _createTask(Task task, String newId) {
    Task newTask = task.copyWith(id: newId);
    setState(() {
      _totalTasks += 1;
      _futureTasks = _futureTasks.then((tasks) {
        final index = tasks.indexWhere((t) => t.id == task.id);
        if (index != -1) {
          tasks[index] = newTask;
        }
        return tasks;
      });
    });
  }

  void _updateTask(Task task) {
    setState(() {
      _futureTasks = _futureTasks.then((tasks) {
        final index = tasks.indexWhere((t) => t.id == task.id);
        if (index != -1) {
          tasks[index] = task;
        }
        return tasks;
      });
    });
  }

  void _handleTaskTitleChange(Task task) {
    if (task.id.isEmpty) {
      _handleCreateTask(task);
    } else {
      _handleUpdateTask(task);
    }
  }

  Future<void> _handleCreateTask(Task task) async {
    try {
      final result = await _taskService.createTask(task);
      _createTask(task, result["task"]["id"]);
    } catch (e) {
      MessageService.showErrorMessage(context, '$e');
    }
  }

  Future<void> _handleUpdateTask(Task task) async {
    try {
      await _taskService.updateTask(task);
      _updateTask(task);
    } catch (e) {
      MessageService.showErrorMessage(context, '$e');
    }
  }

  void _checkTask(Task task) {
    Task newTask = task.copyWith(isChecked: !task.isChecked);
    setState(() {
      _totalTasksChecked += newTask.isChecked ? 1 : -1;
      _futureTasks = _futureTasks.then((tasks) {
        final index = tasks.indexWhere((t) => t.id == task.id);
        if (index != -1) {
          tasks[index] = newTask;
        }
        return tasks;
      });
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      _totalTasks -= 1;
      _totalTasksChecked -= task.isChecked ? 1 : 0;
      _futureTasks = _futureTasks.then((tasks) {
        tasks.removeWhere((t) => t.id == task.id);
        return tasks;
      });
    });
  }

  Future<void> _handleCheckTask(Task task) async {
    try {
      await _taskService.checkTask(task.id);
      _checkTask(task);
    } catch (e) {
      MessageService.showErrorMessage(context, '$e');
    }
  }

  Future<void> _handleDeleteTask(Task task) async {
    try {
      await _taskService.deleteTask(task.id);
      _deleteTask(task);
      MessageService.showSuccesMessage(context, 'Tâche supprimée avec succès');
    } catch (e) {
      MessageService.showErrorMessage(context, '$e');
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
        FutureBuilder<List<Task>>(
          future: _futureTasks,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final tasks = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Column(
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
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: SvgPicture.asset(
                                'assets/icons/trash.svg',
                                colorFilter: ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                        ),
                        child: TaskCard(
                            task: task,
                            onTaskTitleChange: _handleTaskTitleChange,
                            onCheckTask: _handleCheckTask),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  );
                },
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
            onPressed: _onEditingNewTask,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              '+',
              style: TextStyle(
                fontSize: 32.0,
                fontFamily: 'Londrina', // Taille de la police pour le titre
              ),
            ),
          ),
        ),
      ],
    );
  }
}
