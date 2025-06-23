import 'dart:convert';
import '../models/user_model.dart';
import 'api_service.dart';

class ProfileService {
  static Future<AppUser?> getProfile() async {
    final res = await ApiService.get('/users/me', auth: true);

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      final String uid = json['_id']; // ✅ extract UID
      return AppUser.fromJson(uid, json);
    }
    return null;
  }

  static Future<bool> updateProfile(Map<String, dynamic> data) async {
    final res = await ApiService.post('/users/me', data, auth: true);
    return res.statusCode == 200;
  }
}
