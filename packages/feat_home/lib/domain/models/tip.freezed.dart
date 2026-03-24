// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TipImage {

@JsonKey(name: 'src') String get imagePath;@JsonKey(name: 'alt') String get alt;
/// Create a copy of TipImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TipImageCopyWith<TipImage> get copyWith => _$TipImageCopyWithImpl<TipImage>(this as TipImage, _$identity);

  /// Serializes this TipImage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TipImage&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.alt, alt) || other.alt == alt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imagePath,alt);

@override
String toString() {
  return 'TipImage(imagePath: $imagePath, alt: $alt)';
}


}

/// @nodoc
abstract mixin class $TipImageCopyWith<$Res>  {
  factory $TipImageCopyWith(TipImage value, $Res Function(TipImage) _then) = _$TipImageCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'src') String imagePath,@JsonKey(name: 'alt') String alt
});




}
/// @nodoc
class _$TipImageCopyWithImpl<$Res>
    implements $TipImageCopyWith<$Res> {
  _$TipImageCopyWithImpl(this._self, this._then);

  final TipImage _self;
  final $Res Function(TipImage) _then;

/// Create a copy of TipImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imagePath = null,Object? alt = null,}) {
  return _then(_self.copyWith(
imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,alt: null == alt ? _self.alt : alt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TipImage].
extension TipImagePatterns on TipImage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TipImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TipImage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TipImage value)  $default,){
final _that = this;
switch (_that) {
case _TipImage():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TipImage value)?  $default,){
final _that = this;
switch (_that) {
case _TipImage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'src')  String imagePath, @JsonKey(name: 'alt')  String alt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TipImage() when $default != null:
return $default(_that.imagePath,_that.alt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'src')  String imagePath, @JsonKey(name: 'alt')  String alt)  $default,) {final _that = this;
switch (_that) {
case _TipImage():
return $default(_that.imagePath,_that.alt);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'src')  String imagePath, @JsonKey(name: 'alt')  String alt)?  $default,) {final _that = this;
switch (_that) {
case _TipImage() when $default != null:
return $default(_that.imagePath,_that.alt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TipImage implements TipImage {
  const _TipImage({@JsonKey(name: 'src') required this.imagePath, @JsonKey(name: 'alt') required this.alt});
  factory _TipImage.fromJson(Map<String, dynamic> json) => _$TipImageFromJson(json);

@override@JsonKey(name: 'src') final  String imagePath;
@override@JsonKey(name: 'alt') final  String alt;

/// Create a copy of TipImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TipImageCopyWith<_TipImage> get copyWith => __$TipImageCopyWithImpl<_TipImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TipImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TipImage&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.alt, alt) || other.alt == alt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imagePath,alt);

@override
String toString() {
  return 'TipImage(imagePath: $imagePath, alt: $alt)';
}


}

/// @nodoc
abstract mixin class _$TipImageCopyWith<$Res> implements $TipImageCopyWith<$Res> {
  factory _$TipImageCopyWith(_TipImage value, $Res Function(_TipImage) _then) = __$TipImageCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'src') String imagePath,@JsonKey(name: 'alt') String alt
});




}
/// @nodoc
class __$TipImageCopyWithImpl<$Res>
    implements _$TipImageCopyWith<$Res> {
  __$TipImageCopyWithImpl(this._self, this._then);

  final _TipImage _self;
  final $Res Function(_TipImage) _then;

/// Create a copy of TipImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imagePath = null,Object? alt = null,}) {
  return _then(_TipImage(
imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,alt: null == alt ? _self.alt : alt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Tip {

 int get id; String get title; String get description;@JsonKey(name: 'icon') TipImage get image;
/// Create a copy of Tip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TipCopyWith<Tip> get copyWith => _$TipCopyWithImpl<Tip>(this as Tip, _$identity);

  /// Serializes this Tip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tip&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,image);

@override
String toString() {
  return 'Tip(id: $id, title: $title, description: $description, image: $image)';
}


}

/// @nodoc
abstract mixin class $TipCopyWith<$Res>  {
  factory $TipCopyWith(Tip value, $Res Function(Tip) _then) = _$TipCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description,@JsonKey(name: 'icon') TipImage image
});


$TipImageCopyWith<$Res> get image;

}
/// @nodoc
class _$TipCopyWithImpl<$Res>
    implements $TipCopyWith<$Res> {
  _$TipCopyWithImpl(this._self, this._then);

  final Tip _self;
  final $Res Function(Tip) _then;

/// Create a copy of Tip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? image = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as TipImage,
  ));
}
/// Create a copy of Tip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TipImageCopyWith<$Res> get image {
  
  return $TipImageCopyWith<$Res>(_self.image, (value) {
    return _then(_self.copyWith(image: value));
  });
}
}


/// Adds pattern-matching-related methods to [Tip].
extension TipPatterns on Tip {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Tip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Tip() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Tip value)  $default,){
final _that = this;
switch (_that) {
case _Tip():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Tip value)?  $default,){
final _that = this;
switch (_that) {
case _Tip() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String description, @JsonKey(name: 'icon')  TipImage image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Tip() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.image);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String description, @JsonKey(name: 'icon')  TipImage image)  $default,) {final _that = this;
switch (_that) {
case _Tip():
return $default(_that.id,_that.title,_that.description,_that.image);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String description, @JsonKey(name: 'icon')  TipImage image)?  $default,) {final _that = this;
switch (_that) {
case _Tip() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Tip implements Tip {
  const _Tip({required this.id, required this.title, required this.description, @JsonKey(name: 'icon') required this.image});
  factory _Tip.fromJson(Map<String, dynamic> json) => _$TipFromJson(json);

@override final  int id;
@override final  String title;
@override final  String description;
@override@JsonKey(name: 'icon') final  TipImage image;

/// Create a copy of Tip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TipCopyWith<_Tip> get copyWith => __$TipCopyWithImpl<_Tip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TipToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tip&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,image);

@override
String toString() {
  return 'Tip(id: $id, title: $title, description: $description, image: $image)';
}


}

/// @nodoc
abstract mixin class _$TipCopyWith<$Res> implements $TipCopyWith<$Res> {
  factory _$TipCopyWith(_Tip value, $Res Function(_Tip) _then) = __$TipCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description,@JsonKey(name: 'icon') TipImage image
});


@override $TipImageCopyWith<$Res> get image;

}
/// @nodoc
class __$TipCopyWithImpl<$Res>
    implements _$TipCopyWith<$Res> {
  __$TipCopyWithImpl(this._self, this._then);

  final _Tip _self;
  final $Res Function(_Tip) _then;

/// Create a copy of Tip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? image = null,}) {
  return _then(_Tip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as TipImage,
  ));
}

/// Create a copy of Tip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TipImageCopyWith<$Res> get image {
  
  return $TipImageCopyWith<$Res>(_self.image, (value) {
    return _then(_self.copyWith(image: value));
  });
}
}

// dart format on
