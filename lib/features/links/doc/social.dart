import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../var/var.dart';
import 'add_social.dart';

class Social extends StatelessWidget {
  const Social({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    Item social = Item(
      id: id,
      data: state.input.item.data[id],
    );

    return Planet(
      onPressed: () => showAddSocialDialog(social),
      isRound: true,
      noStyling: true,
      padding: padM(),
      tooltip: social.title().cap(),
      child: AppIcon(
        socialBrands[social.title()] ?? FontAwesome.earth_africa_solid,
        size: 24,
        faded: true,
      ),
    );
  }
}
