import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/helpers.dart';

class AddLink extends StatelessWidget {
  const AddLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padL('t'),
      child: Row(
        spacing: sw(),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //
          Planet(
            onPressed: () => addLink(type: itemLinkTypeLink),
            slp: true,
            showBorder: true,
            noStyling: true,
            radius: borderRadiusLarge,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.add, faded: true),
                tpw(),
                Flexible(child: AppText('Add Link', faded: true)),
              ],
            ),
          ),
          //
          Planet(
            onPressed: () => addLink(type: itemLinkTypeTitle),
            slp: true,
            showBorder: true,
            noStyling: true,
            radius: borderRadiusLarge,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.add, faded: true),
                tpw(),
                Flexible(child: AppText('Add Title', faded: true)),
              ],
            ),
          ),
          //
        ],
      ),
    );
  }
}
