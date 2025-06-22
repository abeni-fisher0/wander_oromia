import 'dart:convert';
import 'api_service.dart';

class GuideApi {
  final _api = ApiService();

  Future<bool> uploadProfile(Map<String, dynamic> data) async {
    final res = await _api.post("/guide/upload-profile", data);
    return res.statusCode == 200;
  }

  Future<bool> joinTrail(String trailId) async {
    final res = await _api.post("/guide/join-trail", {"trailId": trailId});
    return res.statusCode == 200;
  }

  Future<Map<String, dynamic>> getProfile() async {
    final res = await _api.get("/guide/profile");
    return jsonDecode(res.body);
  }

  Future<List<String>> getJoinedTrails() async {
    final res = await _api.get("/guide/joined-trails");
    return List<String>.from(jsonDecode(res.body));
  }
}
