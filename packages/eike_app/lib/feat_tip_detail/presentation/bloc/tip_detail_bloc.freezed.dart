// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tip_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TipDetailEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TipDetailEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TipDetailEvent()';
}


}

/// @nodoc
class $TipDetailEventCopyWith<$Res>  {
$TipDetailEventCopyWith(TipDetailEvent _, $Res Function(TipDetailEvent) __);
}


/// Adds pattern-matching-related methods to [TipDetailEvent].
extension TipDetailEventPatterns on TipDetailEvent {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  onSetup,TResult Function( TipUserNote userNote)?  onUserNoteChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup();case _OnUserNoteChanged() when onUserNoteChanged != null:
return onUserNoteChanged(_that.userNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  onSetup,required TResult Function( TipUserNote userNote)  onUserNoteChanged,}) {final _that = this;
switch (_that) {
case _OnSetup():
return onSetup();case _OnUserNoteChanged():
return onUserNoteChanged(_that.userNote);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  onSetup,TResult? Function( TipUserNote userNote)?  onUserNoteChanged,}) {final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup();case _OnUserNoteChanged() when onUserNoteChanged != null:
return onUserNoteChanged(_that.userNote);case _:
  return null;

}
}

}

/// @nodoc


class _OnSetup implements TipDetailEvent {
  const _OnSetup();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnSetup);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TipDetailEvent.onSetup()';
}


}




/// @nodoc


class _OnUserNoteChanged implements TipDetailEvent {
  const _OnUserNoteChanged(this.userNote);
  

 final  TipUserNote userNote;

/// Create a copy of TipDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnUserNoteChangedCopyWith<_OnUserNoteChanged> get copyWith => __$OnUserNoteChangedCopyWithImpl<_OnUserNoteChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnUserNoteChanged&&(identical(other.userNote, userNote) || other.userNote == userNote));
}


@override
int get hashCode {
    return Object.hash(runtimeType,userNote);
}

@override
String toString() {
    return 'TipDetailEvent.onUserNoteChanged(userNote: $userNote)';
}


}

/// @nodoc
abstract mixin class _$OnUserNoteChangedCopyWith<$Res> implements $TipDetailEventCopyWith<$Res> {
  factory _$OnUserNoteChangedCopyWith(_OnUserNoteChanged value, $Res Function(_OnUserNoteChanged) _then) = __$OnUserNoteChangedCopyWithImpl;
@useResult
$Res call({
 TipUserNote userNote
});




}
/// @nodoc
class __$OnUserNoteChangedCopyWithImpl<$Res>
    implements _$OnUserNoteChangedCopyWith<$Res> {
  __$OnUserNoteChangedCopyWithImpl(this._self, this._then);

  final _OnUserNoteChanged _self;
  final $Res Function(_OnUserNoteChanged) _then;

/// Create a copy of TipDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userNote = null,}) {
  return _then(_OnUserNoteChanged(
null == userNote ? _self.userNote : userNote // ignore: cast_nullable_to_non_nullable
as TipUserNote,
  ));
}


}

/// @nodoc
mixin _$TipDetailState {

 TipEntity? get tip; bool get isLoading;
/// Create a copy of TipDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TipDetailStateCopyWith<TipDetailState> get copyWith => _$TipDetailStateCopyWithImpl<TipDetailState>(this as TipDetailState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TipDetailState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TipDetailState&&const DeepCollectionEquality().equals(other.tip, _this.tip)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading));
}


@override
int get hashCode {
  final _this = this as TipDetailState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.tip),_this.isLoading);
}

@override
String toString() {
  final _this = this as TipDetailState;
  return 'TipDetailState(tip: ${_this.tip}, isLoading: ${_this.isLoading})';
}


}

/// @nodoc
abstract mixin class $TipDetailStateCopyWith<$Res>  {
  factory $TipDetailStateCopyWith(TipDetailState value, $Res Function(TipDetailState) _then) = _$TipDetailStateCopyWithImpl;
@useResult
$Res call({
 TipEntity? tip, bool isLoading
});




}
/// @nodoc
class _$TipDetailStateCopyWithImpl<$Res>
    implements $TipDetailStateCopyWith<$Res> {
  _$TipDetailStateCopyWithImpl(this._self, this._then);

  final TipDetailState _self;
  final $Res Function(TipDetailState) _then;

/// Create a copy of TipDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tip = freezed,Object? isLoading = null,}) {
  return _then(TipDetailState(
tip: freezed == tip ? _self.tip : tip // ignore: cast_nullable_to_non_nullable
as TipEntity?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TipDetailState].
extension TipDetailStatePatterns on TipDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TipDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TipDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TipDetailState value)  $default,){
final _that = this;
switch (_that) {
case _TipDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TipDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _TipDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TipEntity? tip,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TipDetailState() when $default != null:
return $default(_that.tip,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TipEntity? tip,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _TipDetailState():
return $default(_that.tip,_that.isLoading);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TipEntity? tip,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _TipDetailState() when $default != null:
return $default(_that.tip,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _TipDetailState implements TipDetailState {
  const _TipDetailState({required this.tip, required this.isLoading});
  

@override final  TipEntity? tip;
@override final  bool isLoading;

/// Create a copy of TipDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TipDetailStateCopyWith<_TipDetailState> get copyWith => __$TipDetailStateCopyWithImpl<_TipDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TipDetailState&&const DeepCollectionEquality().equals(other.tip, tip)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(tip),isLoading);
}

@override
String toString() {
    return 'TipDetailState(tip: $tip, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$TipDetailStateCopyWith<$Res> implements $TipDetailStateCopyWith<$Res> {
  factory _$TipDetailStateCopyWith(_TipDetailState value, $Res Function(_TipDetailState) _then) = __$TipDetailStateCopyWithImpl;
@override @useResult
$Res call({
 TipEntity? tip, bool isLoading
});




}
/// @nodoc
class __$TipDetailStateCopyWithImpl<$Res>
    implements _$TipDetailStateCopyWith<$Res> {
  __$TipDetailStateCopyWithImpl(this._self, this._then);

  final _TipDetailState _self;
  final $Res Function(_TipDetailState) _then;

/// Create a copy of TipDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tip = freezed,Object? isLoading = null,}) {
  return _then(_TipDetailState(
tip: freezed == tip ? _self.tip : tip // ignore: cast_nullable_to_non_nullable
as TipEntity?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
