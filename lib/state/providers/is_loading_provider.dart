import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_whisp/state/auth/providers/authstate_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);

  return authState.isLoading;
});
