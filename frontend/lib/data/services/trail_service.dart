import 'dart:convert';
import '../models/trail_model.dart';
import '../models/saved_trail_model.dart';
import 'api_service.dart';

class TrailService {

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
