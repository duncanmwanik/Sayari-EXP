import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_helpers/nav/navigation.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/sync_indicator.dart';
import '../../../_widgets/others/text.dart';
import '../../spaces/_helpers/common.dart';
import '../../spaces/overview/overview_sheet.dart';

class SpaceName extends StatelessWidget {
  const SpaceName({super.key, this.isMin = false});

  final bool isMin;

  @override
  Widget build(BuildContext context) {
    String spaceId = liveSpace();
    bool isASpaceSelected = spaceId != noValue;

    return Planet(
      noStyling: true,
      padding: noPadding,
      child: Row(
        spacing: tw(),
        mainAxisSize: MainAxisSize.min,
        children: [
          // workspace title
          Flexible(
            child: Planet(
              onPressed: () {
                isSmallPC() ? globalBox.put(drawerType, spaceManagerType) : openDrawer(spaceManagerType);
              },
              srp: true,
              noStyling: true,
              radius: borderRadiusLarge,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // title
                  Flexible(
                    child: ValueListenableBuilder(
                      valueListenable: spaceNamesBox.listenable(),
                      builder: (context, box, widget) {
                        String name = box.get(spaceId, defaultValue: 'Select a space');
                        return AppText(name, weight: ft6, overflow: TextOverflow.ellipsis);
                      },
                    ),
                  ),
                  //
                  tspw(),
                  AppIcon(dropIcon, size: normal, faded: true),
                  //
                ],
              ),
            ),
          ),
          // workspace settings
          Planet(
            onPressed: isASpaceSelected
                ? () => showSpaceOverviewBottomSheet()
                : () {
                    isSmallPC() ? globalBox.put(drawerType, spaceManagerType) : openDrawer(spaceManagerType);
                  },
            tooltip: 'Manage Space',
            noStyling: true,
            isRound: true,
            child: AppIcon(Icons.stacked_bar_chart_rounded, size: normal, extraFaded: true),
          ),
          //
          CloudSyncIndicator(),
          //
        ],
      ),
    );
  }
}
