import 'package:flutter/material.dart';

import '../../../_helpers/common/global.dart';
import '../../../_services/hive/store.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/colors.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../flags/flags_menu.dart';
import '../../spaces/_helpers/common.dart';

class ItemFlag extends StatelessWidget {
  const ItemFlag({super.key, required this.flagId, this.isTinyFlag = false, this.onPressedDelete});

  final String flagId;
  final bool isTinyFlag;
  final Function()? onPressedDelete;

  @override
  Widget build(BuildContext context) {
    String flagData = local(features.flags).get(flagId, defaultValue: '0,Flag');
    String color = flagData.substring(0, flagData.indexOf(','));
    String flag = flagData.substring(flagData.indexOf(',') + 1);

    return Planet(
      menu: isTinyFlag
          ? null
          : flagsMenu(
              alreadySelected: state.input.item.flags(),
              onDone: (newFlags) => newFlags.isNotEmpty ? state.input.update('g', joinList(newFlags)) : state.input.remove('g'),
            ),
      color: backgroundColors[color]!.color,
      padding: isTinyFlag ? noPadding : padC('l8,r4,t2,b2'),
      width: isTinyFlag ? 30 : null,
      height: isTinyFlag ? 8 : null,
      svp: true,
      child: isTinyFlag
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // flag text
                Flexible(child: AppText(flag, color: backgroundColors[color]!.textColor)),
                spw(),
                // remove flag
                if (isAdmin())
                  Planet(
                    onPressed: onPressedDelete ?? () {},
                    noStyling: true,
                    padding: noPadding,
                    child: AppIcon(Icons.close, color: backgroundColors[color]!.textColor, size: normal),
                  ),
                //
              ],
            ),
    );
  }
}
