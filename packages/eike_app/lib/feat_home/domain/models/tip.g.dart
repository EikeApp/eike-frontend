// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TipImage _$TipImageFromJson(Map<String, dynamic> json) =>
    _TipImage(imagePath: json['src'] as String, alt: json['alt'] as String);

Map<String, dynamic> _$TipImageToJson(_TipImage instance) => <String, dynamic>{
  'src': instance.imagePath,
  'alt': instance.alt,
};

_Tip _$TipFromJson(Map<String, dynamic> json) => _Tip(
  id: (json['id'] as num).toInt(),
  position: (json['position'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  image: TipImage.fromJson(json['icon'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TipToJson(_Tip instance) => <String, dynamic>{
  'id': instance.id,
  'position': instance.position,
  'title': instance.title,
  'description': instance.description,
  'icon': instance.image,
};
