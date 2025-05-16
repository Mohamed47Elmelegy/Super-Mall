class Banner {
  final int id;
  final String title;
  final String body;
  final String buttonText;
  final String url;
  final String image;
  final String? link;
  final DateTime createdAt;
  final DateTime updatedAt;

  Banner({
    required this.id,
    required this.title,
    required this.body,
    required this.buttonText,
    required this.url,
    required this.image,
    this.link,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      buttonText: json['button_text'],
      url: json['url'],
      image: json['image'],
      link: json['link'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
