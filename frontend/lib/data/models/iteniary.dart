class ItineraryItem {
  final int day;
  final String trailId;
  final String activity;

  ItineraryItem({
    required this.day,
    required this.trailId,
    required this.activity,
  });

  factory ItineraryItem.fromJson(Map<String, dynamic> json) {
    return ItineraryItem(
      day: json['day'],
      trailId: json['trailId'],
      activity: json['activity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'day': day,
    'trailId': trailId,
    'activity': activity,
  };
}
