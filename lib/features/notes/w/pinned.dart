import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_services/cloud/sync/quick_edit.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';

class PinnedIcon extends StatelessWidget {
  const PinnedIcon({super.key, required this.doc});

  final Item doc;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Planet(
        tooltip: 'Unpin',
        noStyling: true,
        padding: noPadding,
        hoverColor: transparent,
        onPressed: () => quickEdit(action: 'd', parent: doc.parent, id: doc.id, key: itemPinned),
        child: AppIcon(
          pinIcon,
          size: mediumSmall,
          extraFaded: true,
          rotation: 10,
          padding: state.views.isList() ? padN('rl') : padMS('rt'),
        ),
      ),
    );
  }
}
