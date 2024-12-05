import 'package:tie_time_front/models/passion.model.dart';
import 'package:tie_time_front/services/api.service.dart';

class PassionService {
  final ApiService apiService;
  final String prefix = '/passions';

  PassionService({required this.apiService});

  Future<List<Passion>> passions(String currendDate) async {
    List<dynamic> responseBody =
        await apiService.get('$prefix/?date=$currendDate');
    return responseBody.map((passion) => Passion.fromJson(passion)).toList();
  }

  Future<Map<String, dynamic>> checkPassions(String id) async {
    return await apiService.put('$prefix/$id/check', {});
  }
}
