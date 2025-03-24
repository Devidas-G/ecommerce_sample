class Image {
  final String id;
  final String url;
  final String? description;

  Image({required this.id, required this.url, this.description});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      url: json['url'], // Use the 'large' size for the carousel
      description: json['title'],
    );
  }
}
