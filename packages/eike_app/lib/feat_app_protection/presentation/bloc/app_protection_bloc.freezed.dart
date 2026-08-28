// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_protection_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppProtectionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppProtectionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppProtectionState()';
}


}

/// @nodoc
class $AppProtectionStateCopyWith<$Res>  {
$AppProtectionStateCopyWith(AppProtectionState _, $Res Function(AppProtectionState) __);
}


/// Adds pattern-matching-related methods to [AppProtectionState].
extension AppProtectionStatePatterns on AppProtectionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Unlocked value)?  unlocked,TResult Function( _Locked value)?  locked,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Unlocked() when unlocked != null:
return unlocked(_that);case _Locked() when locked != null:
return locked(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Unlocked value)  unlocked,required TResult Function( _Locked value)  locked,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Unlocked():
return unlocked(_that);case _Locked():
return locked(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Unlocked value)?  unlocked,TResult? Function( _Locked value)?  locked,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Unlocked() when unlocked != null:
return unlocked(_that);case _Locked() when locked != null:
return locked(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  unlocked,TResult Function( bool isAuthenticating,  String? errorText)?  locked,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Unlocked() when unlocked != null:
return unlocked();case _Locked() when locked != null:
return locked(_that.isAuthenticating,_that.errorText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  unlocked,required TResult Function( bool isAuthenticating,  String? errorText)  locked,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Unlocked():
return unlocked();case _Locked():
return locked(_that.isAuthenticating,_that.errorText);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  unlocked,TResult? Function( bool isAuthenticating,  String? errorText)?  locked,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Unlocked() when unlocked != null:
return unlocked();case _Locked() when locked != null:
return locked(_that.isAuthenticating,_that.errorText);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AppProtectionState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppProtectionState.initial()';
}


}




/// @nodoc


class _Unlocked implements AppProtectionState {
  const _Unlocked();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unlocked);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppProtectionState.unlocked()';
}


}




/// @nodoc


class _Locked implements AppProtectionState {
  const _Locked({required this.isAuthenticating, required this.errorText});
  

 final  bool isAuthenticating;
 final  String? errorText;

/// Create a copy of AppProtectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LockedCopyWith<_Locked> get copyWith => __$LockedCopyWithImpl<_Locked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Locked&&(identical(other.isAuthenticating, isAuthenticating) || other.isAuthenticating == isAuthenticating)&&(identical(other.errorText, errorText) || other.errorText == errorText));
}


@override
int get hashCode => Object.hash(runtimeType,isAuthenticating,errorText);

@override
String toString() {
  return 'AppProtectionState.locked(isAuthenticating: $isAuthenticating, errorText: $errorText)';
}


}

/// @nodoc
abstract mixin class _$LockedCopyWith<$Res> implements $AppProtectionStateCopyWith<$Res> {
  factory _$LockedCopyWith(_Locked value, $Res Function(_Locked) _then) = __$LockedCopyWithImpl;
@useResult
$Res call({
 bool isAuthenticating, String? errorText
});




}
/// @nodoc
class __$LockedCopyWithImpl<$Res>
    implements _$LockedCopyWith<$Res> {
  __$LockedCopyWithImpl(this._self, this._then);

  final _Locked _self;
  final $Res Function(_Locked) _then;

/// Create a copy of AppProtectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isAuthenticating = null,Object? errorText = freezed,}) {
  return _then(_Locked(
isAuthenticating: null == isAuthenticating ? _self.isAuthenticating : isAuthenticating // ignore: cast_nullable_to_non_nullable
as bool,errorText: freezed == errorText ? _self.errorText : errorText // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$AppProtectionEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppProtectionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppProtectionEvent()';
}


}

/// @nodoc
class $AppProtectionEventCopyWith<$Res>  {
$AppProtectionEventCopyWith(AppProtectionEvent _, $Res Function(AppProtectionEvent) __);
}


/// Adds pattern-matching-related methods to [AppProtectionEvent].
extension AppProtectionEventPatterns on AppProtectionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _OnSetup value)?  onSetup,TResult Function( _OnAppPaused value)?  onAppPaused,TResult Function( _OnAuthRequested value)?  onAuthRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup(_that);case _OnAppPaused() when onAppPaused != null:
return onAppPaused(_that);case _OnAuthRequested() when onAuthRequested != null:
return onAuthRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _OnSetup value)  onSetup,required TResult Function( _OnAppPaused value)  onAppPaused,required TResult Function( _OnAuthRequested value)  onAuthRequested,}){
final _that = this;
switch (_that) {
case _OnSetup():
return onSetup(_that);case _OnAppPaused():
return onAppPaused(_that);case _OnAuthRequested():
return onAuthRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _OnSetup value)?  onSetup,TResult? Function( _OnAppPaused value)?  onAppPaused,TResult? Function( _OnAuthRequested value)?  onAuthRequested,}){
final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup(_that);case _OnAppPaused() when onAppPaused != null:
return onAppPaused(_that);case _OnAuthRequested() when onAuthRequested != null:
return onAuthRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  onSetup,TResult Function()?  onAppPaused,TResult Function()?  onAuthRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup();case _OnAppPaused() when onAppPaused != null:
return onAppPaused();case _OnAuthRequested() when onAuthRequested != null:
return onAuthRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  onSetup,required TResult Function()  onAppPaused,required TResult Function()  onAuthRequested,}) {final _that = this;
switch (_that) {
case _OnSetup():
return onSetup();case _OnAppPaused():
return onAppPaused();case _OnAuthRequested():
return onAuthRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  onSetup,TResult? Function()?  onAppPaused,TResult? Function()?  onAuthRequested,}) {final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup();case _OnAppPaused() when onAppPaused != null:
return onAppPaused();case _OnAuthRequested() when onAuthRequested != null:
return onAuthRequested();case _:
  return null;

}
}

}

/// @nodoc


class _OnSetup implements AppProtectionEvent {
  const _OnSetup();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnSetup);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppProtectionEvent.onSetup()';
}


}




/// @nodoc


class _OnAppPaused implements AppProtectionEvent {
  const _OnAppPaused();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnAppPaused);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppProtectionEvent.onAppPaused()';
}


}




/// @nodoc


class _OnAuthRequested implements AppProtectionEvent {
  const _OnAuthRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnAuthRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppProtectionEvent.onAuthRequested()';
}


}




// dart format on
