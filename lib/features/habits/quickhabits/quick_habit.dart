import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_helpers/common/global.dart';
import '../../../_helpers/extentions/date_time.dart';
import '../../../_models/item.dart';
import '../../../_services/cloud/sync/quick_edit.dart';
import '../../../_services/hive/store.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class QuickHabitItem extends StatelessWidget {
  const QuickHabitItem({
    super.key,
    required this.id,
    this.isLoading = false,
  });

  final String id;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    Item item = Item(
      parent: features.docs,
      id: id,
      data: local(features.docs).get(id, defaultValue: {}),
    );
    String todayKey = '$itemSubItem${now().datePart()}';
    bool isChecked() {
      return Item(
        parent: features.docs,
        id: id,
        data: local(features.docs).get(id, defaultValue: {}),
      ).isHabitChecked(todayKey);
    }

    return Planet(
      onPressed: () {
        bool isTodayChecked = isChecked();
        quickEdit(
          action: isTodayChecked ? 'd' : 'c',
          parent: item.parent,
          id: item.id,
          key: isTodayChecked ? todayKey : todayKey,
          value: getUniqueId(),
        );
      },
      srp: true,
      showBorder: isLight(),
      noStyling: isLight(),
      padding: padC('l8,t6,b6,r8'),
      color: styler.appColor(0.6),
      hoverColor: styler.appColor(0.6),
      child: Visibility(
        visible: !isLoading,
        child: Row(
          children: [
            //
            Expanded(
              child: AppText(item.title(), size: medium, weight: ft6, padding: padC('l2')),
            ),
            // checkbox
            ValueListenableBuilder(
                valueListenable: local(features.docs).listenable(keys: [id]),
                builder: (context, box, wgt) {
                  bool checked = isChecked();

                  return AppIcon(
                    checked ? Icons.verified : Icons.verified_outlined,
                    size: 24,
                    color: checked ? styler.accent() : null,
                    extraFaded: !checked,
                    // padding: padM('lr'),
                  );
                }),
            //
          ],
        ),
      ),
    );
  }
}
