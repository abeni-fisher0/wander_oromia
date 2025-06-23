import 'dart:convert';
import 'dart:io';
import '../models/user_model.dart';
import 'api_service.dart';

class ProfileService {
  static Future<AppUser?> getProfile() async {
    final res = await ApiService.get('/users/me', auth: true);

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      final String uid = json['_id'] ?? '';
      return AppUser.fromJson(uid, json);
    }
    return null;
  }

  static Future<bool> updateProfile(Map<String, dynamic> data) async {
    final res = await ApiService.put('/users/me', data, auth: true);
    return res.statusCode == 200;
  }

  static Future<String?> uploadProfileImage(File imageFile) async {
    try {
      final response = await ApiService.uploadFile(
        '/users/me/avatar',
        imageFile,
        auth: true,
        fileFieldName: 'avatar',
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['avatarUrl'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}