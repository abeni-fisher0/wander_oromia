import 'dart:convert';
import 'api_service.dart';

class UserApi {
  final _api = ApiService();

  Future<Map<String, dynamic>> getProfile() async {
    final res = await _api.get("/user/me");
    return jsonDecode(res.body);
  }

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    final res = await _api.post("/user/update", data);
    return res.statusCode == 200;
  }

  Future<bool> registerUser(String role, String username) async {
    final res = await _api.post("/auth/register", {
      "role": role,
      "username": username,
    });
    return res.statusCode == 200;
  }
}
