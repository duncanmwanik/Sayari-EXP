import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/images.dart';
import '../../notes/layout/button.dart';
import 'escape.dart';

class SharedHeader extends StatelessWidget {
  const SharedHeader({super.key, this.showDivider = true});
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Planet(
      noStyling: true,
      padding: padMS(),
      borderSide: showDivider ? Border(bottom: BorderSide(color: styler.borderColor(), width: 0.5)) : null,
      child: Row(
        children: [
          // branding
          Planet(
            onPressed: () => context.go('/'),
            noStyling: true,
            padding: noPadding,
            hoverColor: transparent,
            child: AppImage('sayari.png', size: 25),
          ),
          Spacer(),
          if (state.share.item.type.isSpace()) LayoutButton(),
          ShareEscape(),
          //
        ],
      ),
    );
  }
}
