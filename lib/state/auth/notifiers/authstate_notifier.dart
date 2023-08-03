import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_whisp/state/auth/backend/authenticator.dart';
import 'package:insta_whisp/state/auth/models/auth_result.dart';
import 'package:insta_whisp/state/auth/models/auth_state.dart';
import 'package:insta_whisp/state/user_info/backend/user_info_storage.dart';
import 'package:insta_whisp/utils/logger.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(const AuthState.loggedOut()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        isLoading: false,
        userId: _authenticator.userId,
        authResult: AuthResult.success,
      );
    }
  }

  final _authenticator = Authenticator();

  Future<void> logOut() async {
    try {
      state = state.copyWithIsLoading(isLoading: true);
      await _authenticator.logOut();
      state = const AuthState.loggedOut();
    } catch (_) {
      'AuthStateNotifier.logOut() function giving errors'.log();
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      state = state.copyWithIsLoading(isLoading: true);
      final result = await _authenticator.signInWithGoogle();
      final userId = _authenticator.userId;
      if (result == AuthResult.success && userId != null) {
        'storing user info to cloud'.log();
        storeUserInfo(userId: userId);
      }
      state = AuthState(isLoading: false, userId: userId, authResult: result);
    } catch (_) {
      'AuthStateNotifier.logOut() function giving errors'.log();
    }
  }

  Future<void> storeUserInfo({required String userId}) async {
    await UserInfoStorage().saveUserInfo(
      userId: userId,
      displayName: _authenticator.displayName,
      email: _authenticator.email,
    );
  }
}
