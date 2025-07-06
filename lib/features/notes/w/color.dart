import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_services/cloud/sync/quick_edit.dart';
import '../../../_theme/colors.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/color_menu.dart';
import '../../../_widgets/others/icons.dart';

class ItemColor extends StatelessWidget {
  const ItemColor({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Planet(
      menu: colorMenu(
        showRemove: true,
        onRemove: () => quickEdit(action: 'd', parent: item.parent, id: item.id, key: itemColor),
        onSelect: (newColor) => quickEdit(parent: item.parent, id: item.id, key: itemColor, value: newColor),
      ),
      isSquare: true,
      noStyling: true,
      margin: padS('r'),
      padding: padS(),
      child: AppIcon(
        Icons.circle,
        color: backgroundColors[item.color()]?.color,
        size: small,
      ),
    );
  }
}
