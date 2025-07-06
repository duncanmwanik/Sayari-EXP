import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../../../_models/item.dart';
import '../../../../_state/input.dart';
import '../../../../_theme/colors.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/prepare.dart';
import '../../overview/overview.dart';

class WeekBox extends StatelessWidget {
  const WeekBox({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    Color textColor = backgroundColors[item.color()]!.textColor;

    return Consumer<InputProvider>(builder: (context, input, child) {
      return Flexible(
        child: Planet(
          onPressed: () => showSessionOverviewDialog(item),
          onLongPress: () => editSession(item),
          padding: padC('l4,r4,t1,b1'),
          margin: padT('b'),
          color: backgroundColors[item.color()]!.color,
          width: double.maxFinite,
          radius: borderRadiusSuperTiny,
          child: AppText(
            size: small,
            item.title(),
            overflow: TextOverflow.clip,
            color: textColor,
            maxlines: 1,
          ),
        ),
      ).animate().slideY();
    });
  }
}
