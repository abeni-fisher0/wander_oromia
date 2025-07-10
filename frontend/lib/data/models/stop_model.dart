class StopModel {
  final String id;
  final String trailId;
  final String name;
  final String description;
  final List<String> images;
  final List<String> videos;
  final double? lat;
  final double? lng;

  StopModel({
    required this.id,
    required this.trailId,
    required this.name,
    required this.description,
    required this.images,
    required this.videos,
    this.lat,
    this.lng,
  });

  factory StopModel.fromJson(Map<String, dynamic> json) {
    return StopModel(
      id: json['_id'] ?? '',
      trailId: json['trailId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      videos: List<String>.from(json['videos'] ?? []),
      lat: json['location']?['lat']?.toDouble(),
      lng: json['location']?['lng']?.toDouble(),
    );
  }
}
