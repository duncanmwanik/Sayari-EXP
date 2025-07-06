import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_state/theme.dart';
import '../../_theme/breakpoints.dart';
import '../../_theme/helpers.dart';
import '../../_theme/variables.dart';
import 'auth.dart';
import 'intro.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    changeStatusAndNavigationBarColor(getThemeType());

    return Consumer<ThemeProvider>(builder: (context, theme, child) {
      return Scaffold(
        backgroundColor: styler.primaryColor(),
        body: Title(
          title: 'Sayari',
          color: styler.accent(),
          child: LayoutBuilder(builder: (ct, cs) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //
                Flexible(
                  child: Auth(),
                ),
                //
                if (isSmallPC())
                  Flexible(
                    child: IntroFeatures(),
                  ),
                //
              ],
            );
          }),
        ),
      );
    });
  }
}
