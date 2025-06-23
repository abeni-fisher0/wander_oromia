import 'dart:convert';
import '../models/stop_model.dart';
import 'api_service.dart';

class StopService {
  static Future<List<StopModel>> getStopsByTrail(String trailId) async {
    final res = await ApiService.get('/stops/$trailId');

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((s) => StopModel.fromJson(s)).toList();
    }
    return [];
  }
}
