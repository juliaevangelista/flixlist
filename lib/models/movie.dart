class Movie {
  final String id;
  final String title;
  final String description;
  final String image;
  final String status;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'status': status,
    };
  }
}
