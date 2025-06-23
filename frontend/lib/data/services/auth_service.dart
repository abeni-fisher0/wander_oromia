import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  /// Logs in a user and stores token + user info
  static Future<String?> login(String email, String password) async {
    final res = await ApiService.post('/auth/login', {
      'email': email,
      'password': password,
    });

    if (res.statusCode == 200) {
      final decoded = jsonDecode(res.body);
      final token = decoded['token'];
      final user = decoded['user']; // optional: if your backend returns it

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      if (user != null) {
        await prefs.setString('user', jsonEncode(user));
      }
      return null; // ✅ success
    } else {
      try {
        final error = jsonDecode(res.body);
        return error['message'] ?? error['error'] ?? 'Login failed';
      } catch (_) {
        return 'Login failed (${res.statusCode})';
      }
    }
  }

  /// Signs up a new user with given data
  static Future<String?> signup(Map<String, dynamic> data) async {
    final res = await ApiService.post('/auth/signup', data);

    if (res.statusCode == 201) {
      return null; // ✅ success
    } else {
      try {
        final error = jsonDecode(res.body);
        return error['message'] ?? error['error'] ?? 'Signup failed';
      } catch (_) {
        return 'Signup failed (${res.statusCode})';
      }
    }
  }

  /// Logs out the current user
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
  }

  /// Returns whether the user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  /// Returns the current JWT token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// Returns stored user as a decoded JSON map
  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    return userJson != null ? jsonDecode(userJson) : null;
  }
}
