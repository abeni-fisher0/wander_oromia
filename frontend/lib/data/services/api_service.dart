import 'package:http/http.dart' as http;
import 'dart:convert';
import 'auth_service.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:5001/wander-oromia/us-central1/api";
  final _auth = AuthService();

  Future<Map<String, String>> getHeaders() async {
    final token = await _auth.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> get(String endpoint) async {
    final headers = await getHeaders();
    return http.get(Uri.parse("$baseUrl$endpoint"), headers: headers);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final headers = await getHeaders();
    return http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: headers,
      body: jsonEncode(body),
    );
  }
}
