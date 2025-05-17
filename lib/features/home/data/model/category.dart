class Category {
  final Map<String, String> name;
  final Map<String, String> description;
  final String slug;
  final String image;
  final bool isActive;
  final String createdAt;

  Category({
    required this.name,
    required this.description,
    required this.image,
    required this.slug,
    required this.isActive,
    required this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: Map<String, String>.from(json['name']),
      description: Map<String, String>.from(json['description']),
      image: json['image'] ?? '',
      slug: json['slug'] ?? '',
      isActive: json['is_active'] == true || json['is_active'] == 1,
      createdAt: json['created_at'] ?? '',
    );
  }
}
