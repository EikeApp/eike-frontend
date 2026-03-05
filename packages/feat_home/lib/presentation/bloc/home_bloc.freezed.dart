// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {

 List<TipEntity> get tips; bool get hasError; bool get isLoading;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&const DeepCollectionEquality().equals(other.tips, tips)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tips),hasError,isLoading);

@override
String toString() {
  return 'HomeState(tips: $tips, hasError: $hasError, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 List<TipEntity> tips, bool hasError, bool isLoading
});




}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tips = null,Object? hasError = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
tips: null == tips ? _self.tips : tips // ignore: cast_nullable_to_non_nullable
as List<TipEntity>,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeState value)  $default,){
final _that = this;
switch (_that) {
case _HomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TipEntity> tips,  bool hasError,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.tips,_that.hasError,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TipEntity> tips,  bool hasError,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _HomeState():
return $default(_that.tips,_that.hasError,_that.isLoading);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TipEntity> tips,  bool hasError,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.tips,_that.hasError,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _HomeState implements HomeState {
  const _HomeState({required final  List<TipEntity> tips, required this.hasError, required this.isLoading}): _tips = tips;
  

 final  List<TipEntity> _tips;
@override List<TipEntity> get tips {
  if (_tips is EqualUnmodifiableListView) return _tips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tips);
}

@override final  bool hasError;
@override final  bool isLoading;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&const DeepCollectionEquality().equals(other._tips, _tips)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tips),hasError,isLoading);

@override
String toString() {
  return 'HomeState(tips: $tips, hasError: $hasError, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 List<TipEntity> tips, bool hasError, bool isLoading
});




}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tips = null,Object? hasError = null,Object? isLoading = null,}) {
  return _then(_HomeState(
tips: null == tips ? _self._tips : tips // ignore: cast_nullable_to_non_nullable
as List<TipEntity>,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$HomeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent()';
}


}

/// @nodoc
class $HomeEventCopyWith<$Res>  {
$HomeEventCopyWith(HomeEvent _, $Res Function(HomeEvent) __);
}


/// Adds pattern-matching-related methods to [HomeEvent].
extension HomeEventPatterns on HomeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _OnSetup value)?  onSetup,TResult Function( _OnUserNoteChanged value)?  onUserNoteChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup(_that);case _OnUserNoteChanged() when onUserNoteChanged != null:
return onUserNoteChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _OnSetup value)  onSetup,required TResult Function( _OnUserNoteChanged value)  onUserNoteChanged,}){
final _that = this;
switch (_that) {
case _OnSetup():
return onSetup(_that);case _OnUserNoteChanged():
return onUserNoteChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _OnSetup value)?  onSetup,TResult? Function( _OnUserNoteChanged value)?  onUserNoteChanged,}){
final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup(_that);case _OnUserNoteChanged() when onUserNoteChanged != null:
return onUserNoteChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  onSetup,TResult Function( TipId tipId,  TipUserNote userNote)?  onUserNoteChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup();case _OnUserNoteChanged() when onUserNoteChanged != null:
return onUserNoteChanged(_that.tipId,_that.userNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  onSetup,required TResult Function( TipId tipId,  TipUserNote userNote)  onUserNoteChanged,}) {final _that = this;
switch (_that) {
case _OnSetup():
return onSetup();case _OnUserNoteChanged():
return onUserNoteChanged(_that.tipId,_that.userNote);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  onSetup,TResult? Function( TipId tipId,  TipUserNote userNote)?  onUserNoteChanged,}) {final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup();case _OnUserNoteChanged() when onUserNoteChanged != null:
return onUserNoteChanged(_that.tipId,_that.userNote);case _:
  return null;

}
}

}

/// @nodoc


class _OnSetup implements HomeEvent {
  const _OnSetup();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnSetup);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.onSetup()';
}


}




/// @nodoc


class _OnUserNoteChanged implements HomeEvent {
  const _OnUserNoteChanged(this.tipId, this.userNote);
  

 final  TipId tipId;
 final  TipUserNote userNote;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnUserNoteChangedCopyWith<_OnUserNoteChanged> get copyWith => __$OnUserNoteChangedCopyWithImpl<_OnUserNoteChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnUserNoteChanged&&(identical(other.tipId, tipId) || other.tipId == tipId)&&(identical(other.userNote, userNote) || other.userNote == userNote));
}


@override
int get hashCode => Object.hash(runtimeType,tipId,userNote);

@override
String toString() {
  return 'HomeEvent.onUserNoteChanged(tipId: $tipId, userNote: $userNote)';
}


}

/// @nodoc
abstract mixin class _$OnUserNoteChangedCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$OnUserNoteChangedCopyWith(_OnUserNoteChanged value, $Res Function(_OnUserNoteChanged) _then) = __$OnUserNoteChangedCopyWithImpl;
@useResult
$Res call({
 TipId tipId, TipUserNote userNote
});




}
/// @nodoc
class __$OnUserNoteChangedCopyWithImpl<$Res>
    implements _$OnUserNoteChangedCopyWith<$Res> {
  __$OnUserNoteChangedCopyWithImpl(this._self, this._then);

  final _OnUserNoteChanged _self;
  final $Res Function(_OnUserNoteChanged) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tipId = null,Object? userNote = null,}) {
  return _then(_OnUserNoteChanged(
null == tipId ? _self.tipId : tipId // ignore: cast_nullable_to_non_nullable
as TipId,null == userNote ? _self.userNote : userNote // ignore: cast_nullable_to_non_nullable
as TipUserNote,
  ));
}


}

// dart format on
