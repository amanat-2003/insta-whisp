import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_whisp/state/auth/providers/authstate_provider.dart';
import 'package:insta_whisp/views/constants/app_colors.dart';
import 'package:insta_whisp/views/constants/strings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleButton extends ConsumerWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: ref.read(authStateProvider.notifier).signInWithGoogle,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.loginButtonColor,
        foregroundColor: AppColors.loginButtonTextColor,
      ),
      child: SizedBox(
        height: 44,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.google,
              color: AppColors.googleColor,
            ),
            const SizedBox(width: 10),
            const Text(Strings.google),
          ],
        ),
      ),
    );
  }
}
