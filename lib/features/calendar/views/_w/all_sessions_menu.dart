import 'package:flutter/material.dart';

import '../../../../_helpers/nav/navigation.dart';
import '../../../../_models/date.dart';
import '../../../../_models/item.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/buttons/close.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/menu/model.dart';
import '../../../../_widgets/others/divider.dart';
import '../../../../_widgets/others/empty.dart';
import '../../../../_widgets/others/future.dart';
import '../../../../_widgets/others/text.dart';
import '../../../spaces/_helpers/common.dart';
import '../../_helpers/prepare.dart';
import '../../_helpers/sort.dart';
import '../daily/box.dart';

Menu sessionListMenu(DateItem date) {
  return Menu(
    items: [
      //
      Row(
        children: [
          //
          Expanded(
            child: Row(
              children: [
                AppCloseButton(),
                tpw(),
                Flexible(child: AppText(size: small, date.dateInfo())),
              ],
            ),
          ),
          //
          if (isASpaceSelected() && isAdmin())
            Planet(
              onPressed: () {
                popWhatsOnTop(); // close menu
                createSession(date: date, hour: TimeOfDay.now().hour);
              },
              tooltip: 'Create Session Today',
              margin: padS('l'),
              noStyling: true,
              isSquare: true,
              iconSize: 20,
              leading: Icons.add_rounded,
            ),
          //
        ],
      ),
      //
      AppDivider(height: sh()),
      //
      AppFuture(
          future: sortSessions(date),
          widget: (sessions) {
            return sessions.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(sessions.length, (index) {
                      String id = sessions.keys.toList()[index];
                      Item item = Item(
                        parent: features.calendar,
                        type: features.calendar,
                        id: id,
                        data: sessions[id],
                      );

                      return DayBox(item: item);
                    }),
                  )
                : EmptyBox(label: 'No sessions today', centered: false, showImage: false);
          }),
      //
      sph(),
      //
    ],
  );
}
