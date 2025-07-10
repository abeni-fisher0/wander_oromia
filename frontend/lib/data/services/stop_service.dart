import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/stop_model.dart';
import '../services/api_service.dart';

class StopService {

  static Future<List<StopModel>> getAllStops() async {
    final res = await ApiService.get('/stops'); // GET /api/stops
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((s) => StopModel.fromJson(s)).toList();
    } else {
      throw Exception('Failed to load stops');
    }
  }
    
  static Future<List<StopModel>> getStopsByTrailId(String trailId) async {
    final res = await ApiService.get('/stops/$trailId');
    
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((s) => StopModel.fromJson(s)).toList();
    } else {
      throw Exception('Failed to load stops');
    }
  }
  static Future<StopModel?> getStopByName(String name) async {
    final encoded = Uri.encodeComponent(name);
    final res = await ApiService.get('/stops/name/$encoded');

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return StopModel.fromJson(json);
    } else {
      print('❌ getStopByName failed: ${res.statusCode} - ${res.body}');
      return null;
    }
  }
  static Future<List<StopModel>> getStopsByTrailTitle(String title) async {
    final encoded = Uri.encodeComponent(title);
    final res = await ApiService.get('/stops/by-trail/$encoded');

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((s) => StopModel.fromJson(s)).toList();
    } else {
      print('🧨 Failed stop fetch (${res.statusCode}): ${res.body}');
      throw Exception('Failed to load stops');
    }
  }
}

 

  
