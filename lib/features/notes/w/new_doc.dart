import 'package:flutter/material.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/_widgets.dart';
import '../../../_widgets/menu/model.dart';
import '../_helpers/prepare.dart';

class NewDoc extends StatelessWidget {
  const NewDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return Planet(
      menu: Menu(
        items: [
          //
          MenuItem(label: 'New Doc', labelSize: small, sh: true, popTrailing: true, faded: true),
          //
          for (String feature in features.personal())
            MenuItem(
              label: feature.cap(),
              leading: feature.icon(),
              leadingSize: medium,
              onTap: () => createDoc(feature),
            ),
        ],
      ),
      noStyling: true,
      showBorder: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcon(addIcon, faded: true, size: normal),
          tspw(),
          AppText('New Doc', size: small, faded: true),
        ],
      ),
    );
  }
}
