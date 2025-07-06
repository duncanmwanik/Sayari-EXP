import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/text.dart';
import '_w/terms.dart';
import 'state/auth.dart';

class AuthTerms extends StatelessWidget {
  const AuthTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthorityProvider>(builder: (context, auth, child) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 270),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            //
            AppText(
              "By continuing, you agree to Sayari's",
              size: tinySmall,
              faded: true,
              textAlign: TextAlign.center,
            ),
            Planet(
              onPressed: () => showTermsSheet(false),
              noStyling: true,
              padding: padS('lr'),
              radius: borderRadiusLarge,
              child: AppText('Terms', size: tinySmall, weight: ft6, color: styler.accent(8)),
            ),
            AppText('and', size: tinySmall, faded: true),
            Planet(
              onPressed: () => showTermsSheet(true),
              noStyling: true,
              padding: padS('lr'),
              radius: borderRadiusLarge,
              child: AppText('Privacy Policy', size: tinySmall, weight: ft6, color: styler.accent(8)),
            ),
            AppText('.', size: tinySmall, faded: true),
            //
          ],
        ),
      );
    });
  }
}
