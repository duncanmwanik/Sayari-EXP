import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_helpers/common/clipboard.dart';
import '../../../_models/date.dart';
import '../../../_models/item.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_services/hive/store.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/close.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/scroll.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/sheets/sheet.dart';
import '../_helpers/common.dart';
import '../_w/space_name.dart';
import 'actions.dart';

Future<void> showSpaceOverviewBottomSheet() async {
  await showAppBottomSheet(
    isFull: true,

    title: spaceNamesBox.get(liveSpace(), defaultValue: 'Untitled'),
    //
    header: Row(
      children: [
        AppCloseButton(isX: false),
        spw(),
        Expanded(child: SpaceName()),
        spw(),
        AppCloseButton(),
      ],
    ),
    //
    content: ValueListenableBuilder(
        valueListenable: local(info).listenable(),
        builder: (context, box, widget) {
          Item item = Item(
            parent: info,
            type: features.space,
            data: box.toMap(),
          );

          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: webMaxWidth),
            child: NoScrollBars(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.content().isNotEmpty) Padding(padding: pad(), child: AppText(item.content(), faded: true)),
                    item.content().isNotEmpty ? tph() : sph(),
                    Planet(
                      leading: 'Starts',
                      trailing: item.start().isNotEmpty ? DateItem(item.start()).dateInfo() : '-',
                      expand: true,
                      color: styler.appColor(isLight() ? 0.6 : 0.3),
                      height: 35,
                    ),
                    tsph(),
                    Planet(
                      leading: 'Ends',
                      trailing: item.end().isNotEmpty ? DateItem(item.end()).dateInfo() : '-',
                      expand: true,
                      color: styler.appColor(isLight() ? 0.6 : 0.3),
                      height: 35,
                    ),
                    tsph(),
                    Planet(
                      leading: 'Space ID',
                      trailing: liveSpace(),
                      onPressed: () => copyText(liveSpace(), description: 'Copied Space ID.'),
                      expand: true,
                      color: styler.appColor(isLight() ? 0.6 : 0.3),
                      height: 35,
                    ),
                    //
                    if (isAdmin()) SpaceActions(item: item),
                    // if (isAdmin()) SpaceMembers(),
                    lpph(),
                    //
                  ],
                ),
              ),
            ),
          );
        }),
  );
}
