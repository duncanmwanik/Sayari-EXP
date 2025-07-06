import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../_theme/spacing.dart';
import '../../../_theme/theme_btn.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/_widgets.dart';
import '../../user/_helpers/helpers.dart';

class ShareEscape extends StatelessWidget {
  const ShareEscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        ThemeButton(),
        //
        Planet(
          onPressed: () => context.go('/'),
          svp: true,
          srp: isSignedIn(),
          slp: !isSignedIn(),
          showBorder: true,
          radius: borderRadiusCrazy,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isSignedIn()) AppImage('sayari.png', size: normal),
              if (!isSignedIn()) tpw(),
              if (!isSignedIn()) AppText('Join Sayari', weight: ft6, color: styler.accent()),
              if (isSignedIn()) AppText('Home', weight: ft6),
              if (isSignedIn()) tpw(),
              if (isSignedIn()) AppIcon(Icons.arrow_forward, size: normal),
            ],
          ),
        ),
      ],
    );
  }
}
