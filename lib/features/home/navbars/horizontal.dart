import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../_services/hive/boxes.dart';
import '../../../_state/theme.dart';
import '../../../_state/views.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/planet.dart';
import 'nav_item.dart';

class HorizontalNavigation extends StatelessWidget {
  const HorizontalNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isSmallPC(),
      child: ValueListenableBuilder(
          valueListenable: settingBox.listenable(),
          builder: (context, box, widget) {
            return Consumer2<ViewsProvider, ThemeProvider>(builder: (context, views, theme, child) {
              return Planet(
                height: 48,
                margin: padM(),
                padding: noPadding,
                color: styler.secondaryColor(),
                radius: borderRadiusMediumSmall,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(child: NavItem(features.timeline)),
                    Flexible(child: NavItem(features.docs)),
                    Flexible(child: NavItem(features.calendar)),
                    Flexible(child: NavItem(features.chat)),
                  ],
                ),
              );
            });
          }),
    );
  }
}
