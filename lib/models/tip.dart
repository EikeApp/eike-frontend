class Tip {
  const Tip({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.alt,
  });

  final int id;
  final String title;
  final String description;
  final String imagePath;
  final String alt;

  factory Tip.fromJson(Map<String, dynamic> json) {
    final icon = (json['icon'] as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};
    final rawSrc = icon['src'] as String? ?? '';
    final normalizedSrc = rawSrc.replaceFirst('./', 'assets/content/');

    return Tip(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: (json['description'] as String? ?? '').trim(),
      imagePath: normalizedSrc,
      alt: icon['alt'] as String? ?? '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Tip &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.imagePath == imagePath &&
        other.alt == alt;
  }

  @override
  int get hashCode => Object.hash(id, title, description, imagePath, alt);

  @override
  String toString() => 'Tip(id: $id, title: $title)';
}
