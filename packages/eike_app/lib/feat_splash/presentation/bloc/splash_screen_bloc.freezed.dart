// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'splash_screen_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SplashScreenEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashScreenEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashScreenEvent()';
}


}

/// @nodoc
class $SplashScreenEventCopyWith<$Res>  {
$SplashScreenEventCopyWith(SplashScreenEvent _, $Res Function(SplashScreenEvent) __);
}


/// Adds pattern-matching-related methods to [SplashScreenEvent].
extension SplashScreenEventPatterns on SplashScreenEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _OnSetup value)?  onSetup,TResult Function( _OnTransitionStarted value)?  onTransitionStarted,TResult Function( _OnTransitionCompleted value)?  onTransitionCompleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup(_that);case _OnTransitionStarted() when onTransitionStarted != null:
return onTransitionStarted(_that);case _OnTransitionCompleted() when onTransitionCompleted != null:
return onTransitionCompleted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _OnSetup value)  onSetup,required TResult Function( _OnTransitionStarted value)  onTransitionStarted,required TResult Function( _OnTransitionCompleted value)  onTransitionCompleted,}){
final _that = this;
switch (_that) {
case _OnSetup():
return onSetup(_that);case _OnTransitionStarted():
return onTransitionStarted(_that);case _OnTransitionCompleted():
return onTransitionCompleted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _OnSetup value)?  onSetup,TResult? Function( _OnTransitionStarted value)?  onTransitionStarted,TResult? Function( _OnTransitionCompleted value)?  onTransitionCompleted,}){
final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup(_that);case _OnTransitionStarted() when onTransitionStarted != null:
return onTransitionStarted(_that);case _OnTransitionCompleted() when onTransitionCompleted != null:
return onTransitionCompleted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  onSetup,TResult Function()?  onTransitionStarted,TResult Function()?  onTransitionCompleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup();case _OnTransitionStarted() when onTransitionStarted != null:
return onTransitionStarted();case _OnTransitionCompleted() when onTransitionCompleted != null:
return onTransitionCompleted();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  onSetup,required TResult Function()  onTransitionStarted,required TResult Function()  onTransitionCompleted,}) {final _that = this;
switch (_that) {
case _OnSetup():
return onSetup();case _OnTransitionStarted():
return onTransitionStarted();case _OnTransitionCompleted():
return onTransitionCompleted();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  onSetup,TResult? Function()?  onTransitionStarted,TResult? Function()?  onTransitionCompleted,}) {final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup();case _OnTransitionStarted() when onTransitionStarted != null:
return onTransitionStarted();case _OnTransitionCompleted() when onTransitionCompleted != null:
return onTransitionCompleted();case _:
  return null;

}
}

}

/// @nodoc


class _OnSetup implements SplashScreenEvent {
  const _OnSetup();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnSetup);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashScreenEvent.onSetup()';
}


}




/// @nodoc


class _OnTransitionStarted implements SplashScreenEvent {
  const _OnTransitionStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnTransitionStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashScreenEvent.onTransitionStarted()';
}


}




/// @nodoc


class _OnTransitionCompleted implements SplashScreenEvent {
  const _OnTransitionCompleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnTransitionCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashScreenEvent.onTransitionCompleted()';
}


}




/// @nodoc
mixin _$SplashScreenState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashScreenState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashScreenState()';
}


}

/// @nodoc
class $SplashScreenStateCopyWith<$Res>  {
$SplashScreenStateCopyWith(SplashScreenState _, $Res Function(SplashScreenState) __);
}


/// Adds pattern-matching-related methods to [SplashScreenState].
extension SplashScreenStatePatterns on SplashScreenState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Splash value)?  splash,TResult Function( _Transitioning value)?  transitioning,TResult Function( _Ready value)?  ready,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Splash() when splash != null:
return splash(_that);case _Transitioning() when transitioning != null:
return transitioning(_that);case _Ready() when ready != null:
return ready(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Splash value)  splash,required TResult Function( _Transitioning value)  transitioning,required TResult Function( _Ready value)  ready,}){
final _that = this;
switch (_that) {
case _Splash():
return splash(_that);case _Transitioning():
return transitioning(_that);case _Ready():
return ready(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Splash value)?  splash,TResult? Function( _Transitioning value)?  transitioning,TResult? Function( _Ready value)?  ready,}){
final _that = this;
switch (_that) {
case _Splash() when splash != null:
return splash(_that);case _Transitioning() when transitioning != null:
return transitioning(_that);case _Ready() when ready != null:
return ready(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  splash,TResult Function()?  transitioning,TResult Function()?  ready,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Splash() when splash != null:
return splash();case _Transitioning() when transitioning != null:
return transitioning();case _Ready() when ready != null:
return ready();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  splash,required TResult Function()  transitioning,required TResult Function()  ready,}) {final _that = this;
switch (_that) {
case _Splash():
return splash();case _Transitioning():
return transitioning();case _Ready():
return ready();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  splash,TResult? Function()?  transitioning,TResult? Function()?  ready,}) {final _that = this;
switch (_that) {
case _Splash() when splash != null:
return splash();case _Transitioning() when transitioning != null:
return transitioning();case _Ready() when ready != null:
return ready();case _:
  return null;

}
}

}

/// @nodoc


class _Splash implements SplashScreenState {
  const _Splash();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Splash);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashScreenState.splash()';
}


}




/// @nodoc


class _Transitioning implements SplashScreenState {
  const _Transitioning();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transitioning);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashScreenState.transitioning()';
}


}




/// @nodoc


class _Ready implements SplashScreenState {
  const _Ready();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ready);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashScreenState.ready()';
}


}




// dart format on
