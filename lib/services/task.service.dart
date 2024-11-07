import 'package:tie_time_front/models/task.model.dart';
import 'package:tie_time_front/services/api.service.dart';

class TaskService {
  final ApiService apiService;
  final String prefix = '/tasks';

  TaskService({required this.apiService});

  Future<List<Task>> tasks(String currendDate) async {
    List<dynamic> responseBody =
        await apiService.get('$prefix/?date=$currendDate');
    return responseBody.map((task) => Task.fromJson(task)).toList();
  }

  Future<Map<String, dynamic>> createTask(Task task) async {
    return await apiService
        .post('$prefix/', {'title': task.title, 'date': task.date.toString()});
  }
}
