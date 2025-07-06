import 'package:flutter/material.dart';

import '../../../_helpers/extentions/dynamic.dart';
import '../../../_helpers/extentions/strings.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/menu/model.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/go_to_view.dart';

class NavItem extends StatelessWidget {
  const NavItem(
    this.type, {
    super.key,
    this.menu,
    this.onPressed,
  });

  final String type;
  final Menu? menu;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    bool isSelected = state.views.view == type;

    return Planet(
      menu: menu,
      onPressed: menu.ok() ? null : onPressed ?? () => goToView(type),
      noStyling: !isSelected,
      color: transparent,
      padding: isSmallPC() ? padC('l9,r6,t6,b6') : null,
      height: isSmallPC() ? null : 48,
      minHeight: 30,
      child: Center(
        child: isSmallPC()
            ? Row(
                children: [
                  AppIcon(type.icon(), size: medium, color: isSelected ? styler.accent() : null, mildFaded: true),
                  Expanded(
                    child: AppText(type.cap(), color: isSelected ? styler.accent() : null, mildFaded: true, padding: padMN('l')),
                  ),
                ],
              )
            : AppIcon(
                type.icon(),
                size: 19,
                color: isSelected ? styler.accent() : null,
                faded: !isSelected,
              ),
        //
      ),
    );
  }
}
