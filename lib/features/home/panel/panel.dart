import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/nav/navigation.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_state/global.dart';
import '../../../_state/views.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/other.dart';
import '../../pomodoro/w/pomo_indicator.dart';
import '../../spaces/manager/manager.dart';
import '../w/demo_btn.dart';
import '../w/test_btn.dart';
import 'items.dart';

class Panel extends StatelessWidget {
  const Panel({super.key, this.isDrawer = false});

  final bool isDrawer;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isSmallPC(),
      child: ValueListenableBuilder(
          valueListenable: globalBox.listenable(keys: ['showPanelOptions', drawerType]),
          builder: (context, box, widget) {
            bool isManager = box.get(drawerType, defaultValue: panelItemsType) == spaceManagerType;
            bool showPanelOptions = box.get('showPanelOptions', defaultValue: true);

            return Consumer2<ViewsProvider, GlobalProvider>(builder: (context, views, global, child) {
              bool isVisible = showPanelOptions || isDrawer;

              return MouseRegion(
                onExit: isDrawer ? (_) => closeDrawer() : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    if (!isVisible)
                      Planet(
                        onHover: isVisible || isDrawer ? null : (_) => openDrawer(panelItemsType),
                        onPressed: () => openDrawer(panelItemsType),
                        isSquare: true,
                        noStyling: true,
                        child: AppIcon(Icons.menu, faded: true),
                      ),
                    //
                    Expanded(
                      child: Planet(
                        onHover: isVisible || isDrawer ? null : (_) => openDrawer(panelItemsType),
                        onPressed: isVisible ? null : () => openDrawer(panelItemsType),
                        width: isVisible ? 270 : 8,
                        height: double.maxFinite,
                        radius: isVisible ? 0 : 17,
                        margin: isVisible ? null : padM('r'),
                        borderSide: isVisible ? Border(right: BorderSide(color: styler.borderColor(), width: 0.3)) : null,
                        color: styler.primaryColor(),
                        padding: noPadding,
                        child: Stack(
                          children: [
                            //
                            isVisible || isDrawer
                                ? isManager
                                    ? SpaceManager().animate().fadeIn()
                                    : PanelItems(isDrawer: isDrawer).animate().fadeIn()
                                : NoWidget(),
                            //
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: padM(),
                                child: Row(
                                  spacing: tw(),
                                  children: [
                                    PomodoroIndicator(alwaysVisible: true),
                                    DemoButton(),
                                    TestButton(),
                                  ],
                                ),
                              ),
                            ),
                            //
                          ],
                        ),
                      ),
                    ),
                    //
                  ],
                ),
              );
            });
          }),
    );
  }
}
