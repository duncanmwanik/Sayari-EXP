import 'package:flutter/material.dart';

import '../../_helpers/common/global.dart';
import '../../_helpers/extentions/date_time.dart';
import '../../_models/item.dart';
import '../../_services/cloud/sync/quick_edit.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import 'month.dart';
import 'progress_bar.dart';

class HabitOverview extends StatelessWidget {
  const HabitOverview({super.key, required this.doc});

  final Item doc;

  @override
  Widget build(BuildContext context) {
    List checkedDates = doc.checkedHabitDates();
    String todayKey = '$itemSubItem${now().datePart()}';
    bool isTodayChecked = checkedDates.contains(todayKey);

    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: padM('t'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            HabitProgressBar(item: doc),
            //
            sph(),
            IgnorePointer(
              child: Transform.scale(
                scale: 0.95,
                child: HabitMonth(item: doc),
              ),
            ),
            sph(),
            //
            Planet(
              onPressed: () => quickEdit(
                action: isTodayChecked ? 'd' : 'c',
                parent: doc.parent,
                id: doc.id,
                key: todayKey,
                value: getUniqueId(),
              ),
              srp: true,
              minHeight: 35,
              radius: 100,
              padding: padC('l10,r5'),
              color: styler.appColor(0.6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: AppText('Today', weight: ft5, size: small, faded: true)),
                  AppIcon(
                    isTodayChecked ? Icons.verified : Icons.verified_outlined,
                    size: 25,
                    color: isTodayChecked ? styler.accent() : null,
                    extraFaded: true,
                  ),
                ],
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
