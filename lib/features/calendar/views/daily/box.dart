import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../_models/date.dart';
import '../../../../_models/item.dart';
import '../../../../_theme/colors.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/others/divider_vertical.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/prepare.dart';
import '../../overview/overview.dart';

class DayBox extends StatelessWidget {
  const DayBox({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    Color textColor = backgroundColors[item.color()]!.textColor;
    DateItem start = DateItem(item.start());
    DateItem end = DateItem(item.end());
    bool isSameDay = start.datePart() == end.datePart();

    return Planet(
      onPressed: () => showSessionOverviewDialog(item),
      onLongPress: () => editSession(item),
      color: backgroundColors[item.color()]!.color.withOpacity(0.8),
      margin: padC('l10,r10,t5'),
      padding: padC('l8,r8,t3,b3'),
      radius: borderRadiusTiny,
      child: Wrap(
        spacing: sw(),
        runSpacing: th(),
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // title
          AppText(item.title(), weight: ft4, color: textColor),
          AppSeparator(padding: noPadding),
          // start
          AppText(
            size: tiny,
            start.timePart12(),
            color: textColor,
            weight: FontWeight.w400,
          ),
          // stop
          AppText(
            size: tiny,
            'to ${isSameDay ? end.timePart12() : end.info()}',
            color: textColor,
            weight: FontWeight.w400,
          ),
          // lead
          if (item.leads().isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.person_rounded, size: tiny, color: textColor),
                tpw(),
                Flexible(child: AppText(size: tiny, item.leads(), color: textColor, weight: FontWeight.w400)),
              ],
            ),
          // venue
          if (item.venue().isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.location_on_rounded, size: tiny, color: textColor),
                tpw(),
                Flexible(child: AppText(size: tiny, item.venue(), color: textColor, weight: FontWeight.w400)),
              ],
            ),
          // files
          if (item.hasFiles())
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.attach_file_rounded, color: textColor, size: tiny),
                tpw(),
                AppText(
                  '${item.fileCount()} file${item.fileCount() > 1 ? 's' : ''} attached',
                  color: textColor,
                  size: tiny,
                  weight: FontWeight.w400,
                )
              ],
            ),
          //
        ],
      ),
    ).animate().fadeIn();
  }
}
