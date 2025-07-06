import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:toastification/toastification.dart';

import '__routing/routes.dart';
import '_helpers/common/init.dart';
import '_helpers/debug/error_handler.dart';
import '_helpers/keyboard/shortcuts.dart';
import '_services/cloud/realtime.dart';
import '_services/hive/load.dart';
import '_services/notifications/init_notifications.dart';
import '_state/_providers.dart';
import '_state/theme.dart';
import '_theme/helpers.dart';
import '_theme/theme.dart';
import '_theme/variables.dart';
import '_widgets/editor/appflowy/appflowy_editor.dart';
import '_widgets/others/scroll.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeHive();
    await initializeFirebase();
    await initializeNotifications();
    initializeMisc();

    runApp(const MyApp());
  }, (error, stackTrace) => handleUnhandledExceptions(error, stackTrace));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: allProviders,
      child: Consumer<ThemeProvider>(builder: (context, theme, child) {
        state.initialize(context);
        bool isDark = isDarkTheme(theme.themeType);
        styler.initialize(isDark);

        return ResponsiveSizer(
          builder: (c, o, s) {
            return Actions(
              actions: actions,
              child: Shortcuts(
                shortcuts: shortcuts,
                child: ToastificationWrapper(
                  child: MaterialApp.router(
                    routerConfig: router,
                    scrollBehavior: AppScrollBehavior(),
                    builder: BotToastInit(),
                    title: 'Sayari',
                    theme: AppTheme.themeData(isDark),
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: [
                      AppFlowyEditorLocalizations.delegate,
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
