import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_services/hive/store.dart';
import '../../../_theme/spacing.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/action.dart';
import '../../../_widgets/dialogs/app_dialog.dart';
import 'notification_item.dart';

Future showSpaceNotificationsDialog() {
  return showAppDialog(
    title: 'Notifications',
    content: ValueListenableBuilder(
        valueListenable: local(notifications).listenable(),
        builder: (context, box, widget) {
          return SingleChildScrollView(
            child: Column(
              children: [
                //
                NotificationItem(type: features.space),
                NotificationItem(type: features.calendar),
                msph(),
                //
              ],
            ),
          );
        }),
    actions: [
      ActionButton(isCancel: true),
      ActionButton(label: 'Save'),
    ],
  );
}
