import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../_helpers/nav/navigation.dart';
import '../../_theme/spacing.dart';
import '../../_theme/theme_menu.dart';
import '../../_theme/variables.dart';
import '../../_widgets/menu/menu_item.dart';
import '../../_widgets/menu/model.dart';
import '../auth/_helpers/sign_out.dart';
import '../pomodoro/sheet.dart';
import '../settings/settings_sheet.dart';
import '_helpers/helpers.dart';
import 'dp.dart';

Menu userMenu() {
  return Menu(
    items: [
      //
      MenuItem(label: '', popTrailing: true, sh: true),
      Center(
        child: UserDp(
          onPressed: () => popWhatsOnTop(todoLast: () => showSettingsBottomSheet()),
          hoverColor: transparent,
          size: 80,
          showBorder: !hasUserDp(),
        ),
      ),
      sph(),
      MenuItem(label: liveUserName(), labelSize: tinySmall, faded: true, sh: true),
      MenuItem(label: liveUserEmail(), labelSize: tinySmall, faded: true, sh: true),
      tph(),
      menuDivider(color: styler.accent()),
      MenuItem(onTap: () => showSettingsBottomSheet(), label: 'Account & Settings', leading: Icons.settings_rounded),
      // MenuItem(label: 'Saved', leading: Icons.bookmark, onTap: () => showSavedSheet()),
      MenuItem(label: 'Pomodoro', leading: Icons.timer, onTap: () => showPomodoroSheet()),
      menuDivider(),
      MenuItem(label: 'Theme', leading: Icons.dark_mode, menu: themeMenu()),
      menuDivider(),
      MenuItem(onTap: () => signOutUser(), label: 'Sign Out', leading: Icons.exit_to_app, faded: true),
      if (kDebugMode) MenuItem(onTap: () async => await clearData(), label: 'Reset App', leading: Icons.restart_alt, faded: true),
      //
    ],
  );
}
