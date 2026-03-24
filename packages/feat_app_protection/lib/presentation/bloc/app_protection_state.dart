part of 'app_protection_bloc.dart';

@freezed
sealed class AppProtectionState with _$AppProtectionState {
  const factory AppProtectionState.initial() = _Initial;
  const factory AppProtectionState.unlocked() = _Unlocked;
  const factory AppProtectionState.locked({
    required bool isAuthenticating,
    required String? errorText,
  }) = _Locked;
}
