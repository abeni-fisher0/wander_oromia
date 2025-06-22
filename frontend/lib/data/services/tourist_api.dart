import 'dart:convert';
import 'api_service.dart';

class TouristApi {
  final _api = ApiService();

  Future<bool> saveTrail(String trailId) async {
    final res = await _api.post("/tourist/save-trail", {"trailId": trailId});
    return res.statusCode == 200;
  }

  Future<List<String>> getSavedTrails() async {
    final res = await _api.get("/tourist/saved-trails");
    return List<String>.from(jsonDecode(res.body));
  }

  Future<List<Map<String, dynamic>>> getItinerary() async {
    final res = await _api.get("/tourist/itinerary");
    return List<Map<String, dynamic>>.from(jsonDecode(res.body));
  }

  Future<bool> selectGuide(String trailId, String guideId) async {
    final res = await _api.post("/tourist/select-guide", {
      "trailId": trailId,
      "guideId": guideId,
    });
    return res.statusCode == 200;
  }

  Future<bool> rateTrail(String trailId, int rating, String comment) async {
    final res = await _api.post("/tourist/rate-trail", {
      "trailId": trailId,
      "rating": rating,
      "comment": comment,
    });
    return res.statusCode == 200;
  }

  Future<bool> rateGuide(String guideId, int rating, String comment) async {
    final res = await _api.post("/tourist/rate-guide", {
      "guideId": guideId,
      "rating": rating,
      "comment": comment,
    });
    return res.statusCode == 200;
  }
}
