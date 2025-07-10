import 'stop_model.dart';

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

  Map<String, dynamic> toJson() {
    return {
      'stopId': stopId,
      'day': day,
      if (notes != null) 'notes': notes,
    };
  }
}

class ItineraryModel {
  final String id;
  final String userId;
  final String? trailId;
  final DateTime startDate;
  final int days;
  final List<String> interests;
  final List<ItineraryStop> stops;

  ItineraryModel({
    required this.id,
    required this.userId,
    this.trailId,
    required this.startDate,
    required this.days,
    required this.interests,
    required this.stops,
  });

  factory ItineraryModel.fromJson(Map<String, dynamic> json) {
    return ItineraryModel(
      id: json['_id'],
      userId: json['userId'],
      trailId: json['trailId'],
      startDate: DateTime.parse(json['startDate']),
      days: json['days'],
      interests: List<String>.from(json['interests'] ?? []),
      stops: (json['stops'] as List).map((s) => ItineraryStop.fromJson(s)).toList(),
    );
  }
}
