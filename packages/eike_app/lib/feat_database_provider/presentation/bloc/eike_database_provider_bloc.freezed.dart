// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eike_database_provider_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EikeDatabaseProviderEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EikeDatabaseProviderEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EikeDatabaseProviderEvent()';
}


}

/// @nodoc
class $EikeDatabaseProviderEventCopyWith<$Res>  {
$EikeDatabaseProviderEventCopyWith(EikeDatabaseProviderEvent _, $Res Function(EikeDatabaseProviderEvent) __);
}


/// Adds pattern-matching-related methods to [EikeDatabaseProviderEvent].
extension EikeDatabaseProviderEventPatterns on EikeDatabaseProviderEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _OnSetup value)?  onSetup,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _OnSetup value)  onSetup,}){
final _that = this;
switch (_that) {
case _OnSetup():
return onSetup(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _OnSetup value)?  onSetup,}){
final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  onSetup,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  onSetup,}) {final _that = this;
switch (_that) {
case _OnSetup():
return onSetup();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  onSetup,}) {final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup();case _:
  return null;

}
}

}

/// @nodoc


class _OnSetup implements EikeDatabaseProviderEvent {
  const _OnSetup();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnSetup);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EikeDatabaseProviderEvent.onSetup()';
}


}




/// @nodoc
mixin _$EikeDatabaseProviderState {

 EikeDatabase? get database; bool get hasError; bool get isLoading;
/// Create a copy of EikeDatabaseProviderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EikeDatabaseProviderStateCopyWith<EikeDatabaseProviderState> get copyWith => _$EikeDatabaseProviderStateCopyWithImpl<EikeDatabaseProviderState>(this as EikeDatabaseProviderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EikeDatabaseProviderState&&(identical(other.database, database) || other.database == database)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,database,hasError,isLoading);

@override
String toString() {
  return 'EikeDatabaseProviderState(database: $database, hasError: $hasError, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $EikeDatabaseProviderStateCopyWith<$Res>  {
  factory $EikeDatabaseProviderStateCopyWith(EikeDatabaseProviderState value, $Res Function(EikeDatabaseProviderState) _then) = _$EikeDatabaseProviderStateCopyWithImpl;
@useResult
$Res call({
 EikeDatabase? database, bool hasError, bool isLoading
});




}
/// @nodoc
class _$EikeDatabaseProviderStateCopyWithImpl<$Res>
    implements $EikeDatabaseProviderStateCopyWith<$Res> {
  _$EikeDatabaseProviderStateCopyWithImpl(this._self, this._then);

  final EikeDatabaseProviderState _self;
  final $Res Function(EikeDatabaseProviderState) _then;

/// Create a copy of EikeDatabaseProviderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? database = freezed,Object? hasError = null,Object? isLoading = null,}) {
  return _then(EikeDatabaseProviderState(
database: freezed == database ? _self.database : database // ignore: cast_nullable_to_non_nullable
as EikeDatabase?,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EikeDatabaseProviderState].
extension EikeDatabaseProviderStatePatterns on EikeDatabaseProviderState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EikeDatabaseProviderState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EikeDatabaseProviderState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EikeDatabaseProviderState value)  $default,){
final _that = this;
switch (_that) {
case _EikeDatabaseProviderState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EikeDatabaseProviderState value)?  $default,){
final _that = this;
switch (_that) {
case _EikeDatabaseProviderState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EikeDatabase? database,  bool hasError,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EikeDatabaseProviderState() when $default != null:
return $default(_that.database,_that.hasError,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EikeDatabase? database,  bool hasError,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _EikeDatabaseProviderState():
return $default(_that.database,_that.hasError,_that.isLoading);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EikeDatabase? database,  bool hasError,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _EikeDatabaseProviderState() when $default != null:
return $default(_that.database,_that.hasError,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _EikeDatabaseProviderState implements EikeDatabaseProviderState {
  const _EikeDatabaseProviderState({required this.database, required this.hasError, required this.isLoading});
  

@override final  EikeDatabase? database;
@override final  bool hasError;
@override final  bool isLoading;

/// Create a copy of EikeDatabaseProviderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EikeDatabaseProviderStateCopyWith<_EikeDatabaseProviderState> get copyWith => __$EikeDatabaseProviderStateCopyWithImpl<_EikeDatabaseProviderState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EikeDatabaseProviderState&&(identical(other.database, database) || other.database == database)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,database,hasError,isLoading);

@override
String toString() {
  return 'EikeDatabaseProviderState(database: $database, hasError: $hasError, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$EikeDatabaseProviderStateCopyWith<$Res> implements $EikeDatabaseProviderStateCopyWith<$Res> {
  factory _$EikeDatabaseProviderStateCopyWith(_EikeDatabaseProviderState value, $Res Function(_EikeDatabaseProviderState) _then) = __$EikeDatabaseProviderStateCopyWithImpl;
@override @useResult
$Res call({
 EikeDatabase? database, bool hasError, bool isLoading
});




}
/// @nodoc
class __$EikeDatabaseProviderStateCopyWithImpl<$Res>
    implements _$EikeDatabaseProviderStateCopyWith<$Res> {
  __$EikeDatabaseProviderStateCopyWithImpl(this._self, this._then);

  final _EikeDatabaseProviderState _self;
  final $Res Function(_EikeDatabaseProviderState) _then;

/// Create a copy of EikeDatabaseProviderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? database = freezed,Object? hasError = null,Object? isLoading = null,}) {
  return _then(_EikeDatabaseProviderState(
database: freezed == database ? _self.database : database // ignore: cast_nullable_to_non_nullable
as EikeDatabase?,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
