import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/_providers.dart';
import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import 'social.dart';
import 'socials_menu.dart';

class Socials extends StatelessWidget {
  const Socials({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      List socialKeys = state.input.item.sharedSocials();

      return Wrap(
        spacing: tw(),
        runSpacing: tw(),
        children: [
          //
          for (String id in socialKeys) Social(id: id),
          //
          Planet(
            menu: socialsMenu(),
            slp: true,
            showBorder: true,
            noStyling: true,
            isRound: socialKeys.isNotEmpty,
            padding: socialKeys.isNotEmpty ? padM() : null,
            radius: borderRadiusLarge,
            tooltip: socialKeys.isNotEmpty ? 'Add Social' : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.add, faded: true),
                if (socialKeys.isEmpty) tpw(),
                if (socialKeys.isEmpty) Flexible(child: AppText('Add Social', faded: true)),
              ],
            ),
          ),
          //
        ],
      );
    });
  }
}
