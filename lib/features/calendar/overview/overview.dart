import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/_widgets.dart';
import '../../../_widgets/files/file_list.dart';
import 'actions.dart';
import 'reminders.dart';
import 'time.dart';
import 'type.dart';

Future showSessionOverviewDialog(Item item) {
  state.input.set(item);

  return showAppDialog(
    contentPadding: padM('lrb'),
    title: AppText(size: normal, item.title(), weight: ft6, padding: padS()),
    content: NoOverScroll(
      child: ListView(
        shrinkWrap: true,
        padding: padS('lr'),
        children: [
          sph(),
          SessionTime(label: 'Starts:', date: item.start()),
          tph(),
          SessionTime(label: 'Ends:', date: item.end()),
          tph(),
          // leads
          if (item.leads().isNotEmpty) sph(),
          if (item.leads().isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.person_rounded, size: normal, faded: true),
                spw(),
                Flexible(child: AppText(item.leads(), faded: true)),
              ],
            ),
          // venue
          if (item.venue().isNotEmpty) sph(),
          if (item.venue().isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.location_on, size: normal, faded: true),
                spw(),
                Flexible(child: AppText(item.venue(), faded: true)),
              ],
            ),
          // reminders
          if (item.hasReminder()) sph(),
          if (item.hasReminder()) SessionReminders(reminderString: item.reminder()),
          // description
          if (item.about().isNotEmpty) sph(),
          if (item.about().isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.subject_rounded, size: normal, faded: true),
                spw(),
                Flexible(child: AppText(item.about(), faded: true)),
              ],
            ),
          // files
          if (item.hasFiles())
            Padding(
              padding: padN('t'),
              child: FileList(item: item, isOverview: true),
            ),
          //
        ],
      ),
    ),
    //
    actions: [
      SessionType(item: item),
      Expanded(child: SessionActions(item: item)),
    ],
    //
  );
}
