// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;

import 'package:insta_whisp/state/auth/models/auth_result.dart';
import 'package:insta_whisp/state/user_info/typedefs/user_id.dart';

@immutable
class AuthState {
  final bool isLoading;
  final UserId? userId;
  final AuthResult? authResult;
  const AuthState({
    required this.isLoading,
    required this.userId,
    required this.authResult,
  });

  const AuthState.loggedOut()
      : isLoading = false,
        authResult = null,
        userId = null;

  AuthState copyWithIsLoading({required bool isLoading}) => AuthState(
        isLoading: isLoading,
        userId: userId,
        authResult: authResult,
      );
}
