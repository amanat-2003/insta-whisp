import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_whisp/firebase_options.dart';
import 'package:insta_whisp/state/auth/notifiers/is_logged_in_provider.dart';
import 'package:insta_whisp/state/auth/providers/authstate_provider.dart';
import 'package:insta_whisp/state/providers/is_loading_provider.dart';
import 'package:insta_whisp/utils/logger.dart';
import 'package:insta_whisp/views/components/loading_screen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 17, 54, 218),
  ),
  textTheme: GoogleFonts.openSansTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo App',
      darkTheme: theme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Consumer(builder: (context, ref, child) {
        ref.listen(isLoadingProvider, (_, isLoading) {
          if (isLoading) {
            LoadingScreen.instance().show(context: context);
          } else {
            LoadingScreen.instance().hide();
          }
        });
        final isLoggedIn = ref.watch(isLoggedInProvider);
        if (isLoggedIn) {
          return const MainView();
        } else {
          return const LoginView();
        }
      }),
    );
  }
}

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main View'),
        actions: [
          TextButton.icon(
            onPressed: ref.read(authStateProvider.notifier).logOut,
            label: const Text('Logout'),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: TextButton(
            onPressed: () {            },
            child: const Text('Show overlay')),
      ),
    );
  }
}

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authStateProvider).authResult?.log();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login View'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: ref.read(authStateProvider.notifier).signInWithGoogle,
            child: const Text('Log in using Google'),
          ),
          // const SizedBox(height: 10),
        ],
      ),
    );
  }
}
