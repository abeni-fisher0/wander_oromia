import 'dart:convert';
import '../models/itinerary_model.dart';
import 'api_service.dart';

class ItineraryService {
  static Future<List<ItineraryModel>> getItineraries() async {
    final res = await ApiService.get('/itineraries', auth: true);

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => ItineraryModel.fromJson(e)).toList();
    }
    return [];
  }

  static Future<bool> createItinerary(Map<String, dynamic> body) async {
    final res = await ApiService.post('/itineraries', body, auth: true);
    return res.statusCode == 201;
  }
}
