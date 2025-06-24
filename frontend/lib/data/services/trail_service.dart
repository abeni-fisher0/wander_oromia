import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/trail_model.dart';
import '../models/saved_trail_model.dart';
import 'api_service.dart';

class TrailService {
  static Future<TrailModel?> getTrailById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/trails/$id'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return TrailModel.fromJson(json);
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching trail: $e');
      return null;
    }
  }

  // Fetch trails by category
  static Future<List<TrailModel>> getTrailsByCategory(String category) async {
    final encodedCategory = Uri.encodeComponent(category);
    final res = await ApiService.get('/trails/category/$encodedCategory');

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((t) => TrailModel.fromJson(t)).toList();
    }
    return [];
  }

  // Search trails
  static Future<List<TrailModel>> searchTrails(String query) async {
    final encodedQuery = Uri.encodeComponent(query);
    final res = await ApiService.get('/trails/search?query=$encodedQuery');

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((t) => TrailModel.fromJson(t)).toList();
    }
    return [];
  }

  static Future<List<TrailModel>> getAllTrails() async {
    final res = await ApiService.get('/trails');

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((t) => TrailModel.fromJson(t)).toList();
    }
    return [];
  }

  static Future<bool> saveTrail(String trailId) async {
    final res = await ApiService.post('/saved', {
      'trailId': trailId,
    }, auth: true);
    return res.statusCode == 201;
  }

  static Future<List<SavedTrailModel>> getSavedTrails() async {
    final res = await ApiService.get('/saved', auth: true);

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((t) => SavedTrailModel.fromJson(t)).toList();
    }
    return [];
  }
}
