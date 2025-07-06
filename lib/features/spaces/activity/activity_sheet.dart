import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_services/hive/store.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/close.dart';
import '../../../_widgets/others/divider.dart';
import '../../../_widgets/others/empty.dart';
import '../../../_widgets/others/scroll.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/sheets/sheet.dart';
import 'dialog_space_activity.dart';

Future<void> showActivityBottomSheet() async {
  await showAppBottomSheet(
    //
    header: Row(
      children: [
        AppCloseButton(isX: false),
        spw(),
        Flexible(child: AppText(size: normal, 'Activity History')),
      ],
    ),
    //
    content: ValueListenableBuilder(
        valueListenable: local(activity).listenable(),
        builder: (context, box, widget) {
          List activities = box.keys.toList().reversed.toList();
          //
          return box.keys.toList().isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: TopBlockedBouncingScrollPhysics(),
                  itemCount: box.keys.toList().length,
                  separatorBuilder: (context, index) => AppDivider(height: 1),
                  itemBuilder: (BuildContext context, int index) {
                    String timestamp = activities[index];
                    String activityText = box.get(timestamp) ?? 'Recent changes were made';
                    String date = timestamp.stampToTime();

                    return ListTile(
                      dense: true,
                      onLongPress: () => showSpaceActivityDialog(timestamp),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusSmall)),
                      title: AppText(activityText),
                      subtitle: AppText(size: small, date, weight: FontWeight.w400, faded: true),
                    );
                  })
              //
              : EmptyBox(label: 'No new activity');
          //
        }),
  );
}
