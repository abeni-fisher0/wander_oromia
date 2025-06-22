import 'dart:convert';
import 'api_service.dart';

class TrailApi {
  final _api = ApiService();

  Future<List<Map<String, dynamic>>> getAllTrails() async {
    final res = await _api.get("/trails");
    return List<Map<String, dynamic>>.from(jsonDecode(res.body));
  }

  Future<Map<String, dynamic>> getTrailById(String trailId) async {
    final res = await _api.get("/trails/$trailId");
    return jsonDecode(res.body);
  }
}
