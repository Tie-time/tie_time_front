import 'package:tie_time_front/models/rate.model.dart';
import 'package:tie_time_front/services/api.service.dart';

class RateService {
  final ApiService apiService;
  final String prefix = '/rates';

  RateService({required this.apiService});

  Future<List<Rate>> rates(String currendDate) async {
    List<dynamic> responseBody =
        await apiService.get('$prefix/?date=$currendDate');
    return responseBody.map((rate) => Rate.fromJson(rate)).toList();
  }

  Future<Map<String, dynamic>> createRate(Rate rate, String date) async {
    return await apiService.post('$prefix/',
        {'type_rate': rate.typeRate, 'date': date, 'score': rate.score});
  }

  Future<Map<String, dynamic>> updateRate(Rate rate) async {
    return await apiService.put('$prefix/${rate.id}', {'score': rate.score});
  }

  Future<Map<String, dynamic>> deleteRate(String id) async {
    return await apiService.delete('$prefix/$id');
  }
}
