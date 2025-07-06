import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../_services/hive/boxes.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../spaces/manager/manager.dart';
import '../panel/panel.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isPanelType = globalBox.get(drawerType, defaultValue: spaceManagerType) == panelItemsType;

    return Drawer(
      elevation: 0,
      width: isPanelType ? 250 : (isPhone() ? 80.w : 250),
      backgroundColor: isSmallPC() ? transparent : styler.primaryColor(),
      surfaceTintColor: transparent,
      shape: RoundedRectangleBorder(),
      child: isSmallPC() ? Panel(isDrawer: true) : SpaceManager(),
    );
  }
}
