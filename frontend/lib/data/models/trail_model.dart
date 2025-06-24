import 'stop_model.dart';

class TrailModel {
  final String id;
  final String title;
  final String category;
  final String description;
  final String imageUrl;
  final List<StopModel> stops;
  final List<String> guides;

  TrailModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.stops,
    required this.guides,
  });

  factory TrailModel.fromJson(Map<String, dynamic> json) {
    return TrailModel(
      id: json['_id'] ?? '', // Fallback
      title: json['title'] ?? 'Untitled Trail',
      category: json['category'] ?? 'Unknown',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      stops:
          (json['stops'] as List<dynamic>? ?? [])
              .map((stop) => StopModel.fromJson(stop))
              .toList(),
      guides: List<String>.from(json['guides'] ?? []),
    );
  }
}
