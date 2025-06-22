import 'dart:convert';
import 'package:http/http.dart' as http;
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

  Future<http.Response> registerUser(String token, String role) {
    return http.post(
      Uri.parse("${_api.baseUrl}/auth/register"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"role": role}),
    );
  }
}
