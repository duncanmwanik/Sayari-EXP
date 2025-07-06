import 'package:flutter/material.dart';

import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/menu/model.dart';
import '../../../../_widgets/others/icons.dart';

class AllSpaceOptions extends StatelessWidget {
  const AllSpaceOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Planet(
      enabled: false,
      menu: Menu(
        items: [
          //
          //
        ],
      ),
      noStyling: true,
      isSquare: true,
      child: AppIcon(moreIcon, extraFaded: true, size: 18),
    );
  }
}
