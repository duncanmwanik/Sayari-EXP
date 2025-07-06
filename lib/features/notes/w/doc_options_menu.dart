import 'package:flutter/material.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/_widgets.dart';
import '../../../_widgets/menu/model.dart';

class DocOptionsMenu extends StatelessWidget {
  const DocOptionsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Planet(
      menu: Menu(
        items: [
          //
          MenuItem(label: 'Type', labelSize: tiny, faded: true),
          //
          for (String feature in features.personal())
            MenuItem(
              label: feature.cap(),
              leading: feature.icon(),
              trailing: state.views.docView == feature ? Icons.done : null,
              leadingSize: medium,
              isSelected: state.views.docView == feature,
              onTap: () => state.views.updateDocView(feature),
            ),
        ],
      ),
      padding: padC('l8,r4,t3,b3'),
      noStyling: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: AppText(state.views.docView.cap(), maxlines: 1, overflow: TextOverflow.clip)),
          tpw(),
          AppIcon(Icons.keyboard_arrow_down, size: normal, faded: true),
        ],
      ),
    );
  }
}
