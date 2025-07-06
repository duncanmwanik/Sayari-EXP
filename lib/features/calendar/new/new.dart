import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/_widgets.dart';
import '../_helpers/prepare.dart';

class NewSession extends StatelessWidget {
  const NewSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Planet(
      onPressed: () => createSession(),
      noStyling: true,
      showBorder: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcon(addIcon, faded: true, size: normal),
          tspw(),
          AppText('New Session', size: small, faded: true),
        ],
      ),
    );
  }
}
