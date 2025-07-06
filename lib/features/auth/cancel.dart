import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_theme/spacing.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/icons.dart';
import 'state/auth.dart';

class AuthCancel extends StatelessWidget {
  const AuthCancel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthorityProvider>(builder: (context, auth, child) {
      return Visibility(
        visible: !auth.showAll(),
        child: Align(
          alignment: Alignment.topLeft,
          child: Planet(
            onPressed: () => auth.reset(),
            isRound: true,
            noStyling: true,
            showBorder: true,
            borderWidth: 0.3,
            margin: padMN('b'),
            child: AppIcon(Icons.arrow_back, size: 24, faded: true),
          ),
        ),
      );
    });
  }
}
