class Announcement {
  final int? id;
  final String title;
  final String description;
  final String category;

  Announcement({
    this.id,
    required this.title,
    required this.description,
    required this.category,
  });

  // Convert Announcement object into a Map object for saving in DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
    };
  }

  // Convert Map object back into an Announcement object for retrieving from DB
  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
    );
  }
}
