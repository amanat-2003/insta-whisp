import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_whisp/state/auth/models/auth_state.dart';
import 'package:insta_whisp/state/auth/notifiers/authstate_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (_) => AuthStateNotifier(),
);
