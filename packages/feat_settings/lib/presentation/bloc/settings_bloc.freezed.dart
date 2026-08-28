// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState {

 bool get isAppLockEnabled;
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsStateCopyWith<SettingsState> get copyWith => _$SettingsStateCopyWithImpl<SettingsState>(this as SettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState&&(identical(other.isAppLockEnabled, isAppLockEnabled) || other.isAppLockEnabled == isAppLockEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,isAppLockEnabled);

@override
String toString() {
  return 'SettingsState(isAppLockEnabled: $isAppLockEnabled)';
}


}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res>  {
  factory $SettingsStateCopyWith(SettingsState value, $Res Function(SettingsState) _then) = _$SettingsStateCopyWithImpl;
@useResult
$Res call({
 bool isAppLockEnabled
});




}
/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isAppLockEnabled = null,}) {
  return _then(SettingsState(
isAppLockEnabled: null == isAppLockEnabled ? _self.isAppLockEnabled : isAppLockEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsState value)  $default,){
final _that = this;
switch (_that) {
case _SettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isAppLockEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.isAppLockEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isAppLockEnabled)  $default,) {final _that = this;
switch (_that) {
case _SettingsState():
return $default(_that.isAppLockEnabled);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isAppLockEnabled)?  $default,) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.isAppLockEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsState implements SettingsState {
  const _SettingsState({required this.isAppLockEnabled});
  

@override final  bool isAppLockEnabled;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsStateCopyWith<_SettingsState> get copyWith => __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsState&&(identical(other.isAppLockEnabled, isAppLockEnabled) || other.isAppLockEnabled == isAppLockEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,isAppLockEnabled);

@override
String toString() {
  return 'SettingsState(isAppLockEnabled: $isAppLockEnabled)';
}


}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(_SettingsState value, $Res Function(_SettingsState) _then) = __$SettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isAppLockEnabled
});




}
/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isAppLockEnabled = null,}) {
  return _then(_SettingsState(
isAppLockEnabled: null == isAppLockEnabled ? _self.isAppLockEnabled : isAppLockEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$SettingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent()';
}


}

/// @nodoc
class $SettingsEventCopyWith<$Res>  {
$SettingsEventCopyWith(SettingsEvent _, $Res Function(SettingsEvent) __);
}


/// Adds pattern-matching-related methods to [SettingsEvent].
extension SettingsEventPatterns on SettingsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _OnSetup value)?  onSetup,TResult Function( _OnUpsertTeamContact value)?  onUpsertTeamContact,TResult Function( _OnCleanupLocalStorage value)?  onCleanupLocalStorage,TResult Function( _OnSetIsAppLockEnabled value)?  onSetIsAppLockEnabled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup(_that);case _OnUpsertTeamContact() when onUpsertTeamContact != null:
return onUpsertTeamContact(_that);case _OnCleanupLocalStorage() when onCleanupLocalStorage != null:
return onCleanupLocalStorage(_that);case _OnSetIsAppLockEnabled() when onSetIsAppLockEnabled != null:
return onSetIsAppLockEnabled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _OnSetup value)  onSetup,required TResult Function( _OnUpsertTeamContact value)  onUpsertTeamContact,required TResult Function( _OnCleanupLocalStorage value)  onCleanupLocalStorage,required TResult Function( _OnSetIsAppLockEnabled value)  onSetIsAppLockEnabled,}){
final _that = this;
switch (_that) {
case _OnSetup():
return onSetup(_that);case _OnUpsertTeamContact():
return onUpsertTeamContact(_that);case _OnCleanupLocalStorage():
return onCleanupLocalStorage(_that);case _OnSetIsAppLockEnabled():
return onSetIsAppLockEnabled(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _OnSetup value)?  onSetup,TResult? Function( _OnUpsertTeamContact value)?  onUpsertTeamContact,TResult? Function( _OnCleanupLocalStorage value)?  onCleanupLocalStorage,TResult? Function( _OnSetIsAppLockEnabled value)?  onSetIsAppLockEnabled,}){
final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup(_that);case _OnUpsertTeamContact() when onUpsertTeamContact != null:
return onUpsertTeamContact(_that);case _OnCleanupLocalStorage() when onCleanupLocalStorage != null:
return onCleanupLocalStorage(_that);case _OnSetIsAppLockEnabled() when onSetIsAppLockEnabled != null:
return onSetIsAppLockEnabled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  onSetup,TResult Function()?  onUpsertTeamContact,TResult Function()?  onCleanupLocalStorage,TResult Function( bool isEnabled)?  onSetIsAppLockEnabled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup();case _OnUpsertTeamContact() when onUpsertTeamContact != null:
return onUpsertTeamContact();case _OnCleanupLocalStorage() when onCleanupLocalStorage != null:
return onCleanupLocalStorage();case _OnSetIsAppLockEnabled() when onSetIsAppLockEnabled != null:
return onSetIsAppLockEnabled(_that.isEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  onSetup,required TResult Function()  onUpsertTeamContact,required TResult Function()  onCleanupLocalStorage,required TResult Function( bool isEnabled)  onSetIsAppLockEnabled,}) {final _that = this;
switch (_that) {
case _OnSetup():
return onSetup();case _OnUpsertTeamContact():
return onUpsertTeamContact();case _OnCleanupLocalStorage():
return onCleanupLocalStorage();case _OnSetIsAppLockEnabled():
return onSetIsAppLockEnabled(_that.isEnabled);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  onSetup,TResult? Function()?  onUpsertTeamContact,TResult? Function()?  onCleanupLocalStorage,TResult? Function( bool isEnabled)?  onSetIsAppLockEnabled,}) {final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup();case _OnUpsertTeamContact() when onUpsertTeamContact != null:
return onUpsertTeamContact();case _OnCleanupLocalStorage() when onCleanupLocalStorage != null:
return onCleanupLocalStorage();case _OnSetIsAppLockEnabled() when onSetIsAppLockEnabled != null:
return onSetIsAppLockEnabled(_that.isEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _OnSetup implements SettingsEvent {
  const _OnSetup();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnSetup);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.onSetup()';
}


}




/// @nodoc


class _OnUpsertTeamContact implements SettingsEvent {
  const _OnUpsertTeamContact();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnUpsertTeamContact);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.onUpsertTeamContact()';
}


}




/// @nodoc


class _OnCleanupLocalStorage implements SettingsEvent {
  const _OnCleanupLocalStorage();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnCleanupLocalStorage);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.onCleanupLocalStorage()';
}


}




/// @nodoc


class _OnSetIsAppLockEnabled implements SettingsEvent {
  const _OnSetIsAppLockEnabled(this.isEnabled);
  

 final  bool isEnabled;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnSetIsAppLockEnabledCopyWith<_OnSetIsAppLockEnabled> get copyWith => __$OnSetIsAppLockEnabledCopyWithImpl<_OnSetIsAppLockEnabled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnSetIsAppLockEnabled&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,isEnabled);

@override
String toString() {
  return 'SettingsEvent.onSetIsAppLockEnabled(isEnabled: $isEnabled)';
}


}

/// @nodoc
abstract mixin class _$OnSetIsAppLockEnabledCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory _$OnSetIsAppLockEnabledCopyWith(_OnSetIsAppLockEnabled value, $Res Function(_OnSetIsAppLockEnabled) _then) = __$OnSetIsAppLockEnabledCopyWithImpl;
@useResult
$Res call({
 bool isEnabled
});




}
/// @nodoc
class __$OnSetIsAppLockEnabledCopyWithImpl<$Res>
    implements _$OnSetIsAppLockEnabledCopyWith<$Res> {
  __$OnSetIsAppLockEnabledCopyWithImpl(this._self, this._then);

  final _OnSetIsAppLockEnabled _self;
  final $Res Function(_OnSetIsAppLockEnabled) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isEnabled = null,}) {
  return _then(_OnSetIsAppLockEnabled(
null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
