// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'url_launcher_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UrlLauncherEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UrlLauncherEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UrlLauncherEvent()';
}


}

/// @nodoc
class $UrlLauncherEventCopyWith<$Res>  {
$UrlLauncherEventCopyWith(UrlLauncherEvent _, $Res Function(UrlLauncherEvent) __);
}


/// Adds pattern-matching-related methods to [UrlLauncherEvent].
extension UrlLauncherEventPatterns on UrlLauncherEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _OnSetup value)?  onSetup,TResult Function( _OnLaunchUrl value)?  onLaunchUrl,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup(_that);case _OnLaunchUrl() when onLaunchUrl != null:
return onLaunchUrl(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _OnSetup value)  onSetup,required TResult Function( _OnLaunchUrl value)  onLaunchUrl,}){
final _that = this;
switch (_that) {
case _OnSetup():
return onSetup(_that);case _OnLaunchUrl():
return onLaunchUrl(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _OnSetup value)?  onSetup,TResult? Function( _OnLaunchUrl value)?  onLaunchUrl,}){
final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup(_that);case _OnLaunchUrl() when onLaunchUrl != null:
return onLaunchUrl(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  onSetup,TResult Function( Uri url)?  onLaunchUrl,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup();case _OnLaunchUrl() when onLaunchUrl != null:
return onLaunchUrl(_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  onSetup,required TResult Function( Uri url)  onLaunchUrl,}) {final _that = this;
switch (_that) {
case _OnSetup():
return onSetup();case _OnLaunchUrl():
return onLaunchUrl(_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  onSetup,TResult? Function( Uri url)?  onLaunchUrl,}) {final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup();case _OnLaunchUrl() when onLaunchUrl != null:
return onLaunchUrl(_that.url);case _:
  return null;

}
}

}

/// @nodoc


class _OnSetup implements UrlLauncherEvent {
  const _OnSetup();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnSetup);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UrlLauncherEvent.onSetup()';
}


}




/// @nodoc


class _OnLaunchUrl implements UrlLauncherEvent {
  const _OnLaunchUrl(this.url);
  

 final  Uri url;

/// Create a copy of UrlLauncherEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnLaunchUrlCopyWith<_OnLaunchUrl> get copyWith => __$OnLaunchUrlCopyWithImpl<_OnLaunchUrl>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnLaunchUrl&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'UrlLauncherEvent.onLaunchUrl(url: $url)';
}


}

/// @nodoc
abstract mixin class _$OnLaunchUrlCopyWith<$Res> implements $UrlLauncherEventCopyWith<$Res> {
  factory _$OnLaunchUrlCopyWith(_OnLaunchUrl value, $Res Function(_OnLaunchUrl) _then) = __$OnLaunchUrlCopyWithImpl;
@useResult
$Res call({
 Uri url
});




}
/// @nodoc
class __$OnLaunchUrlCopyWithImpl<$Res>
    implements _$OnLaunchUrlCopyWith<$Res> {
  __$OnLaunchUrlCopyWithImpl(this._self, this._then);

  final _OnLaunchUrl _self;
  final $Res Function(_OnLaunchUrl) _then;

/// Create a copy of UrlLauncherEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(_OnLaunchUrl(
null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Uri,
  ));
}


}

/// @nodoc
mixin _$UrlLauncherState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UrlLauncherState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UrlLauncherState()';
}


}

/// @nodoc
class $UrlLauncherStateCopyWith<$Res>  {
$UrlLauncherStateCopyWith(UrlLauncherState _, $Res Function(UrlLauncherState) __);
}


/// Adds pattern-matching-related methods to [UrlLauncherState].
extension UrlLauncherStatePatterns on UrlLauncherState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UrlLauncherState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UrlLauncherState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UrlLauncherState value)  $default,){
final _that = this;
switch (_that) {
case _UrlLauncherState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UrlLauncherState value)?  $default,){
final _that = this;
switch (_that) {
case _UrlLauncherState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function()?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UrlLauncherState() when $default != null:
return $default();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function()  $default,) {final _that = this;
switch (_that) {
case _UrlLauncherState():
return $default();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function()?  $default,) {final _that = this;
switch (_that) {
case _UrlLauncherState() when $default != null:
return $default();case _:
  return null;

}
}

}

/// @nodoc


class _UrlLauncherState implements UrlLauncherState {
  const _UrlLauncherState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UrlLauncherState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UrlLauncherState()';
}


}




// dart format on
