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
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'position') required int position,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'description') required String description,
    @JsonKey(name: 'question') required String? question,
    @JsonKey(name: 'icon') required TipImage image,
  }) = _Tip;

  factory Tip.fromJson(Map<String, dynamic> json) => _$TipFromJson(json);
}
