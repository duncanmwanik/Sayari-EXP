import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../_models/item.dart';
import '../../../../_theme/colors.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/prepare.dart';
import '../../overview/overview.dart';

class MonthBox extends StatelessWidget {
  const MonthBox({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.1.w, vertical: 0.1.h),
      child: Planet(
        onPressed: () => showSessionOverviewDialog(item),
        onLongPress: () => editSession(item),
        color: backgroundColors[item.color()]!.color,
        padding: padC('l5,r5,t1,b1'),
        radius: borderRadiusSuperTiny,
        child: AppText(
          size: small,
          item.title(),
          overflow: TextOverflow.ellipsis,
          color: backgroundColors[item.color()]!.textColor,
          maxlines: 1,
        ),
      ),
    ).animate().slideY();
  }
}
