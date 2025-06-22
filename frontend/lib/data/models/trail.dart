class Trail {
  final String id;
  final String name;
  final String category;
  final String description;
  final List<String> stops;
  final List<String> guideIds;

  Trail({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.stops,
    required this.guideIds,
  });

  factory Trail.fromJson(Map<String, dynamic> json) {
    return Trail(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      stops: List<String>.from(json['stops'] ?? []),
      guideIds: List<String>.from(json['guideIds'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category,
    'description': description,
    'stops': stops,
    'guideIds': guideIds,
  };
}
