import 'dart:convert';
import 'package:frontend/data/models/itinerary_model.dart';
import 'api_service.dart';

class ItineraryService {
  static Future<bool> createItinerary(Map<String, dynamic> data) async {
    final res = await ApiService.post('/itineraries', data, auth: true);
    return res.statusCode == 201;
  }

  static Future<List<ItineraryModel>> getItineraries() async {
    final res = await ApiService.get('/itineraries', auth: true);
    if (res.statusCode == 200) {
      final List decoded = jsonDecode(res.body);
      return decoded.map((e) => ItineraryModel.fromJson(e)).toList();
    }
    return [];
  }
}
