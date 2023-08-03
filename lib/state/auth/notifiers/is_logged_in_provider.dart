import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_whisp/state/auth/models/auth_result.dart';
import 'package:insta_whisp/state/auth/providers/authstate_provider.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.authResult == AuthResult.success;
});
