import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../_variables/navigation.dart';
import '../_widgets/error/error_screen.dart';
import '../features/auth/_helpers/user_details_helper.dart';
import '../features/auth/view.dart';
import '../features/home/home.dart';
import '../features/share/w_shared/test.dart';
import '../features/share/w_shared/view.dart';
import '../features/timeline/drive.dart';
import '../features/timeline/play.dart';

final GoRouter router = GoRouter(
  observers: [BotToastNavigatorObserver()],
  navigatorKey: navigatorState,
  routes: [
    // home
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
      redirect: (context, state) async {
        if (await isFirstTimer()) {
          return '/signin';
        }
        return null;
      },
    ),
    //
    GoRoute(
      path: '/:params',
      builder: (context, state) {
        // signin
        if (state.pathParameters['params'] == 'signin') {
          return AuthScreen();
        }
        // play
        else if (state.pathParameters['params'] == 'drive') {
          return SignInDemo();
        } else if (state.pathParameters['params'] == 'play') {
          return PlayView();
        }
        // shared items
        else {
          return SharedView(params: state.pathParameters['params'] ?? '');
        }
      },
    ),
    // test
    GoRoute(path: '/test/:params', builder: (context, state) => TestScreen(params: state.pathParameters['params'])),
  ],
  // error
  errorPageBuilder: (context, state) => MaterialPage(child: ErrorScreen()),
);
