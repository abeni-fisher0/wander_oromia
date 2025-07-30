import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:frontend/data/models/guide_model.dart';
import 'package:frontend/core/utils/token_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:frontend/data/models/trail_model.dart';

class GuideService {
  static const String baseUrl = 'http://192.168.1.11:5000/api';

  static Future<bool> uploadGuide({
    required String name,
    required String phone,
    required String address,
    required String experience,
    required List<String> languages,
    required String price,
    required String trailId,
    required File imageFile,
  }) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      print('❌ No token found');
      return false;
    }

    final decoded = JwtDecoder.decode(token);
    final userId = decoded['uid'];

    final uri = Uri.parse('$baseUrl/guides');
    final request = http.MultipartRequest('POST', uri);

    request.fields['name'] = name;
    request.fields['phone'] = phone;
    request.fields['address'] = address;
    request.fields['experience'] = experience;
    request.fields['languages'] = jsonEncode(languages);
    request.fields['price'] = price;
    request.fields['trails'] = jsonEncode([trailId]);
    request.fields['userId'] = userId;

    request.files.add(
      await http.MultipartFile.fromPath('photo', imageFile.path),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      print('✅ Guide uploaded');
      return true;
    } else {
      print('❌ Upload failed: ${response.statusCode}');
      print('Body: ${response.body}');
      return false;
    }
  }

  static Future<List<TrailModel>> getSavedTrailsByGuide(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/guides/saved-trails/$userId'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => TrailModel.fromJson(e)).toList();
    } else {
      print('❌ Failed to fetch saved trails: ${response.body}');
      throw Exception('Failed to fetch saved trails');
    }
  }

  static Future<List<GuideModel>> getGuidesByTrail(String trailId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/guides/trail/$trailId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => GuideModel.fromJson(e)).toList();
    } else {
      print('❌ Backend error: ${response.statusCode}');
      print('Body: ${response.body}');
      throw Exception('Failed to fetch guides');
    }
  }
}
