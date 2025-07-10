class GuideModel {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String experience;
  final String? language;
  final String? photo;
  final String? trailId;
  final double? price;

  GuideModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.experience,
    this.language,
    this.photo,
    this.trailId,
    this.price,
  });

  factory GuideModel.fromJson(Map<String, dynamic> json) {
    return GuideModel(
      id: json['_id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      experience: json['experience'],
      language: json['language'],
      photo: json['photo'],
      trailId: json['trailId'],
      price: (json['price'] as num?)?.toDouble(),
    );
  }
}
