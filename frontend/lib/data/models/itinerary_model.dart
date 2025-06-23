import 'stop_model.dart';

class ItineraryModel {
  final String id;
  final String userId;
  final String trailId;
  final List<ItineraryStop> stops;

  ItineraryModel({
    required this.id,
    required this.userId,
    required this.trailId,
    required this.stops,
  });

  factory ItineraryModel.fromJson(Map<String, dynamic> json) {
    return ItineraryModel(
      id: json['_id'],
      userId: json['userId'],
      trailId: json['trailId'],
      stops:
          (json['stops'] as List)
              .map((s) => ItineraryStop.fromJson(s))
              .toList(),
    );
  }
}

class ItineraryStop {
  final String stopId;
  final int day;
  final String? notes;

  ItineraryStop({required this.stopId, required this.day, this.notes});

  factory ItineraryStop.fromJson(Map<String, dynamic> json) {
    return ItineraryStop(
      stopId: json['stopId'],
      day: json['day'],
      notes: json['notes'],
    );
  }
}
