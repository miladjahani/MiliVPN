import 'package:flutter/material.dart';

import 'state/app_state.dart';
import 'ui/home_page.dart';
import 'ui/setup_wizard.dart';
import 'ui/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final state = AppState();
  await state.init();
  runApp(MiliApp(state: state));
}

class MiliApp extends StatelessWidget {
  final AppState state;
  const MiliApp({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: state,
      // Rebuilds only when the theme colour or mode changes (picked in Settings).
      child: ListenableBuilder(
        listenable: Listenable.merge([state.themeColor, state.themeMode]),
        builder: (context, _) => MaterialApp(
          title: 'MiliConfig',
          debugShowCheckedModeBanner: false,
          // Android can draw the app into the navigation bar area (notably with
          // gesture navigation). Keep every route's content above that inset.
          builder: (context, child) => SafeArea(
            top: false,
            child: child ?? const SizedBox.shrink(),
          ),
          theme: buildTheme(Brightness.light, state.themeColor.value),
          darkTheme: buildTheme(Brightness.dark, state.themeColor.value),
          themeMode: state.themeMode.value,
          home: const _Root(),
        ),
      ),
    );
  }
}

/// The setup wizard until a VPN worker is set up, then the home page.
class _Root extends StatelessWidget {
  const _Root();

  @override
  Widget build(BuildContext context) {
    final needsSetup = AppScope.of(context).needsSetup;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: needsSetup ? const SetupWizard(key: ValueKey('setup')) : const HomePage(key: ValueKey('home')),
    );
  }
}
