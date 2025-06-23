import 'trail_model.dart';

class SavedTrailModel {
  final String id;
  final String userId;
  final String role;
  final TrailModel trail;

  SavedTrailModel({
    required this.id,
    required this.userId,
    required this.role,
    required this.trail,
  });

  factory SavedTrailModel.fromJson(Map<String, dynamic> json) {
    return SavedTrailModel(
      id: json['_id'],
      userId: json['userId'],
      role: json['role'],
      trail: TrailModel.fromJson(json['trailId']),
    );
  }
}
