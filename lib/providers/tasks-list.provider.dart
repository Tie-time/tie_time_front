import 'package:flutter/material.dart';
import 'package:tie_time_front/models/task.model.dart';
import 'package:tie_time_front/services/messages.service.dart';
import 'package:tie_time_front/services/task.service.dart';

class TaskProvider with ChangeNotifier {
  final TaskService _taskService;
  BuildContext? _context;
  List<Task> _tasks = [];
  int _totalTasksChecked = 0;

  TaskProvider(this._taskService);

  List<Task> get tasks => _tasks;
  int get totalTasksChecked => _totalTasksChecked;
  int get totalTasks => _tasks.length;

  void setContext(BuildContext context) {
    _context = context;
  }

// Utiliser le context stocké dans les méthodes
  void _showError(String message) {
    if (_context != null) {
      MessageService.showErrorMessage(_context!, message);
    }
  }

// Utiliser le context stocké dans les méthodes
  void _showSuccess(String message) {
    if (_context != null) {
      MessageService.showSuccesMessage(_context!, message);
    }
  }

  Future<void> loadTasks(DateTime date) async {
    _tasks = await _taskService.tasks(date.toString());
    _totalTasksChecked = _tasks.where((task) => task.isChecked).length;
    notifyListeners();
  }

  void _createTask(Task task, String newId) {
    Task newTask = task.copyWith(id: newId);
    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = newTask;
      notifyListeners();
    }
  }

  void _updateTask(Task task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  void _checkTask(Task task) {
    Task newTask = task.copyWith(isChecked: !task.isChecked);
    _totalTasksChecked += newTask.isChecked ? 1 : -1;
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = newTask;
      notifyListeners();
    }
  }

  void _deleteTask(Task task) {
    _totalTasksChecked -= task.isChecked ? 1 : 0;
    _tasks.removeWhere((t) => t.id == task.id);
    notifyListeners();
  }

  void onEditingNewTask(DateTime date) {
    _tasks.add(Task(
        id: '',
        title: '',
        isChecked: false,
        date: date,
        order: tasks.length,
        isEditing: true));
    notifyListeners();
  }

  void handleTaskTitleChange(Task task) {
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
      _showError('$e');
    }
  }

  Future<void> _handleUpdateTask(Task task) async {
    try {
      await _taskService.updateTask(task);
      _updateTask(task);
    } catch (e) {
      _showError('$e');
    }
  }

  Future<void> handleCheckTask(Task task) async {
    try {
      await _taskService.checkTask(task.id);
      _checkTask(task);
    } catch (e) {
      _showError('$e');
    }
  }

  Future<void> handleDeleteTask(Task task) async {
    try {
      await _taskService.deleteTask(task.id);
      _deleteTask(task);
      _showSuccess('Tâche supprimée avec succès');
    } catch (e) {
      _showError('$e');
    }
  }
}
