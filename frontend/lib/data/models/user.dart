class AppUser {
  final String uid;
  final String? fullName;
  final String? phone;
  final String role;
  final List<String> savedTrails;
  final List<Map<String, dynamic>> itinerary;

  AppUser({
    required this.uid,
    this.fullName,
    this.phone,
    required this.role,
    required this.savedTrails,
    required this.itinerary,
  });

  factory AppUser.fromJson(String uid, Map<String, dynamic> json) {
    return AppUser(
      uid: uid,
      fullName: json['fullName'],
      phone: json['phone'],
      role: json['role'] ?? 'tourist',
      savedTrails: List<String>.from(json['savedTrails'] ?? []),
      itinerary: List<Map<String, dynamic>>.from(json['itinerary'] ?? []),
    );
  }
}
