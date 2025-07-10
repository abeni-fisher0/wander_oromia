import 'guide_model.dart';
import 'trail_model.dart';

class BookingModel {
  final String userId;
  final String guideId;
  final String trailId;
  final String? itineraryId;
  final DateTime date;
  final String? notes;

  final GuideModel? guide;
  final TrailModel? trail;

  BookingModel({
    required this.userId,
    required this.guideId,
    required this.trailId,
    this.itineraryId,
    required this.date,
    this.notes,
    this.guide,
    this.trail,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      userId: json['userId'] is Map ? json['userId']['_id'] : json['userId'],
      guideId: json['guideId'] is Map ? json['guideId']['_id'] : json['guideId'],
      trailId: json['trailId'] is Map ? json['trailId']['_id'] : json['trailId'],
      itineraryId: json['itineraryId'],
      date: DateTime.parse(json['date']),
      notes: json['notes'],
      guide: json['guideId'] is Map ? GuideModel.fromJson(json['guideId']) : null,
      trail: json['trailId'] is Map ? TrailModel.fromJson(json['trailId']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'guideId': guideId,
      'trailId': trailId,
      'itineraryId': itineraryId,
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }
}
