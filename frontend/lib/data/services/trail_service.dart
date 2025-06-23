import 'dart:convert';
import '../models/trail_model.dart';
import '../models/saved_trail_model.dart';
import 'api_service.dart';

class TrailService {
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
