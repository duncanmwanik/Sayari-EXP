import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../_services/hive/boxes.dart';
import '../../_state/theme.dart';
import '../../_theme/breakpoints.dart';
import '../../_theme/spacing.dart';
import '../../_variables/constants.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/files/image.dart';
import '../../_widgets/menu/model.dart';
import '../../_widgets/others/icons.dart';
import '_helpers/helpers.dart';
import 'dp_menu.dart';

class UserDp extends StatelessWidget {
  const UserDp({
    super.key,
    this.userId,
    this.tooltip,
    this.size,
    this.onPressed,
    this.onLongPress,
    this.menu,
    this.hoverColor,
    this.isTiny = true,
    this.showBorder = false,
    this.showDpOptions = false,
  });

  final String? userId;
  final String? tooltip;
  final double? size;
  final Function()? onPressed;
  final Function()? onLongPress;
  final Menu? menu;
  final Color? hoverColor;
  final bool isTiny;
  final bool showBorder;
  final bool showDpOptions;

  @override
  Widget build(BuildContext context) {
    double size_ = size ?? (isTiny ? 26 : 100);

    return Consumer<ThemeProvider>(builder: (context, theme, child) {
      return ValueListenableBuilder(
          valueListenable: userInfoBox.listenable(keys: [itemUserDp]),
          builder: (context, box, widget) {
            return Stack(
              children: [
                //dp
                Planet(
                  tooltip: tooltip,
                  onPressed: onPressed,
                  menu: menu,
                  onLongPress: onLongPress,
                  minHeight: size_,
                  minWidth: size_,
                  isSquare: true,
                  showBorder: showBorder,
                  dryWidth: true,
                  padding: padT(),
                  margin: !isSmallPC() ? padM('l') : null,
                  color: hoverColor,
                  hoverColor: hoverColor,
                  radius: 100,
                  child: hasUserDp()
                      ? ImageFile(
                          userDpId(),
                          userDpName(),
                          db: users,
                          space: liveUser(),
                          showOptions: false,
                          size: size_,
                          radius: 100,
                          offline: true,
                          ignore: true,
                        )
                      : AppIcon(Icons.person, size: size_ * 0.6, extraFaded: true),
                ),
                //
                if (showDpOptions)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Planet(
                      menu: dpEditMenu(),
                      isSquare: true,
                      noStyling: true,
                      child: AppIcon(Icons.more_horiz, faded: true),
                    ),
                  ),
                //
              ],
            );
          });
    });
  }
}
