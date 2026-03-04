import 'package:freezed_annotation/freezed_annotation.dart';

part 'tip.freezed.dart';
part 'tip.g.dart';

@freezed
sealed class TipImage with _$TipImage {
  const factory TipImage({
    @JsonKey(name: 'src') required String imagePath,
    @JsonKey(name: 'alt') required String alt,
  }) = _TipImage;

  factory TipImage.fromJson(Map<String, dynamic> json) =>
      _$TipImageFromJson(json);
}

@freezed
sealed class Tip with _$Tip {
  const factory Tip({
    required int id,
    required String title,
    required String description,
    @JsonKey(name: 'icon') required TipImage image,
  }) = _Tip;

  factory Tip.fromJson(Map<String, dynamic> json) => _$TipFromJson(json);
}

// class Tip {
//   const Tip({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.imagePath,
//     required this.alt,
//   });
//
//   final int id;
//   final String title;
//   final String description;
//   final String imagePath;
//   final String alt;
//
//   factory Tip.fromJson(Map<String, dynamic> json) {
//     final icon =
//         (json['icon'] as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};
//     final rawSrc = icon['src'] as String? ?? '';
//     final normalizedSrc = rawSrc.replaceFirst('./', 'assets/content/');
//
//     return Tip(
//       id: json['id'] as int? ?? 0,
//       title: json['title'] as String? ?? '',
//       description: (json['description'] as String? ?? '').trim(),
//       imagePath: normalizedSrc,
//       alt: icon['alt'] as String? ?? '',
//     );
//   }
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     return other is Tip &&
//         other.id == id &&
//         other.title == title &&
//         other.description == description &&
//         other.imagePath == imagePath &&
//         other.alt == alt;
//   }
//
//   @override
//   int get hashCode => Object.hash(id, title, description, imagePath, alt);
//
//   @override
//   String toString() => 'Tip(id: $id, title: $title)';
// }
