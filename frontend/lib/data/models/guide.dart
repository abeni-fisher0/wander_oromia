class GuideProfile {
  final String uid;
  final String? bio;
  final List<String> languages;
  final List<String> registeredTrails;

  GuideProfile({
    required this.uid,
    this.bio,
    required this.languages,
    required this.registeredTrails,
  });

  factory GuideProfile.fromJson(String uid, Map<String, dynamic> json) {
    return GuideProfile(
      uid: uid,
      bio: json['bio'],
      languages: List<String>.from(json['languages'] ?? []),
      registeredTrails: List<String>.from(json['registeredTrails'] ?? []),
    );
  }
}
