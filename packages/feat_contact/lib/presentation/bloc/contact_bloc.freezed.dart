// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContactEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactEvent()';
}


}

/// @nodoc
class $ContactEventCopyWith<$Res>  {
$ContactEventCopyWith(ContactEvent _, $Res Function(ContactEvent) __);
}


/// Adds pattern-matching-related methods to [ContactEvent].
extension ContactEventPatterns on ContactEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _OnSetup value)?  onSetup,TResult Function( _OnSetTeamContactData value)?  onSetTeamContactData,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup(_that);case _OnSetTeamContactData() when onSetTeamContactData != null:
return onSetTeamContactData(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _OnSetup value)  onSetup,required TResult Function( _OnSetTeamContactData value)  onSetTeamContactData,}){
final _that = this;
switch (_that) {
case _OnSetup():
return onSetup(_that);case _OnSetTeamContactData():
return onSetTeamContactData(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _OnSetup value)?  onSetup,TResult? Function( _OnSetTeamContactData value)?  onSetTeamContactData,}){
final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup(_that);case _OnSetTeamContactData() when onSetTeamContactData != null:
return onSetTeamContactData(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  onSetup,TResult Function( TeamContactTeamName teamName,  TeamContactPhone phoneNumber,  TeamContactEmail email)?  onSetTeamContactData,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup();case _OnSetTeamContactData() when onSetTeamContactData != null:
return onSetTeamContactData(_that.teamName,_that.phoneNumber,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  onSetup,required TResult Function( TeamContactTeamName teamName,  TeamContactPhone phoneNumber,  TeamContactEmail email)  onSetTeamContactData,}) {final _that = this;
switch (_that) {
case _OnSetup():
return onSetup();case _OnSetTeamContactData():
return onSetTeamContactData(_that.teamName,_that.phoneNumber,_that.email);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  onSetup,TResult? Function( TeamContactTeamName teamName,  TeamContactPhone phoneNumber,  TeamContactEmail email)?  onSetTeamContactData,}) {final _that = this;
switch (_that) {
case _OnSetup() when onSetup != null:
return onSetup();case _OnSetTeamContactData() when onSetTeamContactData != null:
return onSetTeamContactData(_that.teamName,_that.phoneNumber,_that.email);case _:
  return null;

}
}

}

/// @nodoc


class _OnSetup implements ContactEvent {
  const _OnSetup();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnSetup);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContactEvent.onSetup()';
}


}




/// @nodoc


class _OnSetTeamContactData implements ContactEvent {
  const _OnSetTeamContactData({required this.teamName, required this.phoneNumber, required this.email});
  

 final  TeamContactTeamName teamName;
 final  TeamContactPhone phoneNumber;
 final  TeamContactEmail email;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnSetTeamContactDataCopyWith<_OnSetTeamContactData> get copyWith => __$OnSetTeamContactDataCopyWithImpl<_OnSetTeamContactData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnSetTeamContactData&&(identical(other.teamName, teamName) || other.teamName == teamName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,teamName,phoneNumber,email);

@override
String toString() {
  return 'ContactEvent.onSetTeamContactData(teamName: $teamName, phoneNumber: $phoneNumber, email: $email)';
}


}

/// @nodoc
abstract mixin class _$OnSetTeamContactDataCopyWith<$Res> implements $ContactEventCopyWith<$Res> {
  factory _$OnSetTeamContactDataCopyWith(_OnSetTeamContactData value, $Res Function(_OnSetTeamContactData) _then) = __$OnSetTeamContactDataCopyWithImpl;
@useResult
$Res call({
 TeamContactTeamName teamName, TeamContactPhone phoneNumber, TeamContactEmail email
});




}
/// @nodoc
class __$OnSetTeamContactDataCopyWithImpl<$Res>
    implements _$OnSetTeamContactDataCopyWith<$Res> {
  __$OnSetTeamContactDataCopyWithImpl(this._self, this._then);

  final _OnSetTeamContactData _self;
  final $Res Function(_OnSetTeamContactData) _then;

/// Create a copy of ContactEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? teamName = null,Object? phoneNumber = null,Object? email = null,}) {
  return _then(_OnSetTeamContactData(
teamName: null == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as TeamContactTeamName,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as TeamContactPhone,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as TeamContactEmail,
  ));
}


}

/// @nodoc
mixin _$ContactState {

 TeamContactEntity? get teamContact;
/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactStateCopyWith<ContactState> get copyWith => _$ContactStateCopyWithImpl<ContactState>(this as ContactState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactState&&(identical(other.teamContact, teamContact) || other.teamContact == teamContact));
}


@override
int get hashCode => Object.hash(runtimeType,teamContact);

@override
String toString() {
  return 'ContactState(teamContact: $teamContact)';
}


}

/// @nodoc
abstract mixin class $ContactStateCopyWith<$Res>  {
  factory $ContactStateCopyWith(ContactState value, $Res Function(ContactState) _then) = _$ContactStateCopyWithImpl;
@useResult
$Res call({
 TeamContactEntity? teamContact
});




}
/// @nodoc
class _$ContactStateCopyWithImpl<$Res>
    implements $ContactStateCopyWith<$Res> {
  _$ContactStateCopyWithImpl(this._self, this._then);

  final ContactState _self;
  final $Res Function(ContactState) _then;

/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teamContact = freezed,}) {
  return _then(ContactState(
teamContact: freezed == teamContact ? _self.teamContact : teamContact // ignore: cast_nullable_to_non_nullable
as TeamContactEntity?,
  ));
}

}


/// Adds pattern-matching-related methods to [ContactState].
extension ContactStatePatterns on ContactState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactState value)  $default,){
final _that = this;
switch (_that) {
case _ContactState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactState value)?  $default,){
final _that = this;
switch (_that) {
case _ContactState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TeamContactEntity? teamContact)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactState() when $default != null:
return $default(_that.teamContact);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TeamContactEntity? teamContact)  $default,) {final _that = this;
switch (_that) {
case _ContactState():
return $default(_that.teamContact);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TeamContactEntity? teamContact)?  $default,) {final _that = this;
switch (_that) {
case _ContactState() when $default != null:
return $default(_that.teamContact);case _:
  return null;

}
}

}

/// @nodoc


class _ContactState implements ContactState {
  const _ContactState({required this.teamContact});
  

@override final  TeamContactEntity? teamContact;

/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactStateCopyWith<_ContactState> get copyWith => __$ContactStateCopyWithImpl<_ContactState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactState&&(identical(other.teamContact, teamContact) || other.teamContact == teamContact));
}


@override
int get hashCode => Object.hash(runtimeType,teamContact);

@override
String toString() {
  return 'ContactState(teamContact: $teamContact)';
}


}

/// @nodoc
abstract mixin class _$ContactStateCopyWith<$Res> implements $ContactStateCopyWith<$Res> {
  factory _$ContactStateCopyWith(_ContactState value, $Res Function(_ContactState) _then) = __$ContactStateCopyWithImpl;
@override @useResult
$Res call({
 TeamContactEntity? teamContact
});




}
/// @nodoc
class __$ContactStateCopyWithImpl<$Res>
    implements _$ContactStateCopyWith<$Res> {
  __$ContactStateCopyWithImpl(this._self, this._then);

  final _ContactState _self;
  final $Res Function(_ContactState) _then;

/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teamContact = freezed,}) {
  return _then(_ContactState(
teamContact: freezed == teamContact ? _self.teamContact : teamContact // ignore: cast_nullable_to_non_nullable
as TeamContactEntity?,
  ));
}


}

// dart format on
