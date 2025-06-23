class TrailModel {
  final String id;
  final String title;
  final String category;
  final String description;
  final String imageUrl;

  TrailModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
  });

  factory TrailModel.fromJson(Map<String, dynamic> json) {
    return TrailModel(
      id: json['_id'],
      title: json['title'],
      category: json['category'],
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
