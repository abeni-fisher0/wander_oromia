import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const String baseUrl = 'http://192.168.1.11:5000/api';

class ApiService {
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<http.Response> get(String endpoint, {bool auth = false}) async {
    final token = auth ? await _getToken() : null;
    return http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (auth) 'Authorization': 'Bearer $token',
      },
    );
  }

  static Future<http.Response> post(
    String endpoint,
    dynamic body, {
    bool auth = false,
  }) async {
    final token = auth ? await _getToken() : null;
    return http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (auth) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }
}
