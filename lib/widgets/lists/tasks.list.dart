import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tie_time_front/config/environnement.config.dart';
import 'package:tie_time_front/providers/settings.provider.dart';
import 'package:tie_time_front/providers/tasks-list.provider.dart';
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
  late TaskProvider _taskProvider;
  late Future<void> _loadTasksFuture;

  @override
  void initState() {
    super.initState();
    _taskProvider = TaskProvider(
        TaskService(apiService: ApiService(baseUrl: Environnement.apiUrl)));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _taskProvider.setContext(context);
    });
    _loadTasksFuture =
        _taskProvider.loadTasks(widget.currentDateNotifier.value);
    widget.currentDateNotifier.addListener(() {
      _loadTasksFuture =
          _taskProvider.loadTasks(widget.currentDateNotifier.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _taskProvider,
      child: Consumer2<TaskProvider, SettingsProvider>(
        builder: (context, taskProvider, settingsProvider, child) {
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${taskProvider.totalTasksChecked}/',
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3A3E),
                        ),
                      ),
                      TextSpan(
                        text: taskProvider.totalTasks.toString(),
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: taskProvider.totalTasks >
                                    settingsProvider.settings.maxTasks
                                ? Color(0xFFE95569)
                                : Color(0xFF2D3A3E)),
                      ),
                      TextSpan(
                        text:
                            ' Tâches (max ${settingsProvider.settings.maxTasks})',
                        style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3A3E)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              FutureBuilder<void>(
                future: _loadTasksFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      MessageService.showErrorMessage(
                          context, snapshot.error.toString());
                    });
                    return Container();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: taskProvider.tasks.length,
                      itemBuilder: (context, index) {
                        final task = taskProvider.tasks[index];
                        return Column(
                          children: [
                            Dismissible(
                              direction: DismissDirection.endToStart,
                              key: Key(task.id),
                              onDismissed: (direction) {
                                taskProvider.handleDeleteTask(task);
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
                                  onTaskTitleChange:
                                      taskProvider.handleTaskTitleChange,
                                  onCheckTask: taskProvider.handleCheckTask),
                            ),
                            const SizedBox(height: 16.0),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  onPressed: () => taskProvider
                      .onEditingNewTask(widget.currentDateNotifier.value),
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
            ],
          );
        },
      ),
    );
  }
}
