import 'package:tie_time_front/models/passion.model.dart';
import 'package:tie_time_front/services/api.service.dart';

class PassionService {
  final ApiService apiService;
  final String prefix = '/passions';

  PassionService({required this.apiService});

  Future<List<Passion>> passions(String date) async {
    List<dynamic> responseBody = await apiService.get('$prefix/?date=$date');
    return responseBody.map((passion) => Passion.fromJson(passion)).toList();
  }

  Future<Map<String, dynamic>> checkPassion(int id, String date) async {
    return await apiService.post('$prefix/$id/check/?date=$date', {});
  }
}
