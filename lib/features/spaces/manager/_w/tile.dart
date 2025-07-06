import 'package:flutter/material.dart';

import '../../../../_services/hive/boxes.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.title,
    required this.count,
    this.trailing,
    required this.child,
    this.iconData = Icons.folder_rounded,
    this.initiallyExpanded = false,
  });

  final String title;
  final int count;
  final Widget? trailing;
  final Widget child;
  final IconData iconData;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Planet(
      showBorder: true,
      noStyling: true,
      padding: noPadding,
      margin: padS('b'),
      radius: borderRadiusSmall + 4,
      child: Theme(
        data: expansionTileThemeData,
        child: ExpansionTile(
          dense: true,
          initiallyExpanded: globalBox.get(title, defaultValue: initiallyExpanded),
          onExpansionChanged: (value) => globalBox.put(title, value),
          tilePadding: EdgeInsets.only(left: 10, right: 5),
          childrenPadding: padMS(),
          shape: Border(),
          iconColor: styler.textColor(faded: true),
          trailing: trailing,
          title: Row(
            children: [
              AppIcon(iconData, faded: true, size: 18),
              mpw(),
              Expanded(child: AppText(title)),
              tpw(),
              AppText(size: small, '$count', faded: true),
            ],
          ),
          children: [child],
        ),
      ),
    );
  }
}
