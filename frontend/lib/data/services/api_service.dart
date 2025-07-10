import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

const String baseUrl = 'http://192.168.1.6:5000/api';


class ApiService {
  // Existing methods...
  static Future<http.Response> put(String endpoint, dynamic body, {bool auth = false}) async {
    final token = auth ? await _getToken() : null;
    return http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (auth) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
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

  static Future<http.Response> post(String endpoint, dynamic body, {bool auth = false}) async {
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

  // New method for file uploads
  static Future<http.Response> uploadFile(
    String endpoint,
    File file, {
    bool auth = false,
    String fileFieldName = 'file',
  }) async {
    final token = auth ? await _getToken() : null;
    
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl$endpoint'),
    );

    request.headers.addAll({
      if (auth) 'Authorization': 'Bearer $token',
    });

    request.files.add(
      await http.MultipartFile.fromPath(
        fileFieldName,
        file.path,
      ),
    );

    var response = await http.Response.fromStream(await request.send());
    return response;
  }

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}