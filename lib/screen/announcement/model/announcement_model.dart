class Announcement {
  final String title;
  final String description;
  final String category;
  final DateTime dateCreated;
  final DateTime dateUpdated;

  Announcement({
    required this.title,
    required this.description,
    required this.category,
    DateTime? dateCreated,
    DateTime? dateUpdated,
  })  : dateCreated = dateCreated ?? DateTime.now(),
        dateUpdated = dateUpdated ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'dateCreated': dateCreated.toIso8601String(),
      'dateUpdated': dateUpdated.toIso8601String(),
    };
  }

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      title: map['title'],
      description: map['description'],
      category: map['category'],
      dateCreated: DateTime.parse(map['dateCreated']),
      dateUpdated: DateTime.parse(map['dateUpdated']),
    );
  }
}
