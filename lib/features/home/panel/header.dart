import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../user/dp.dart';
import '../../user/user_menu.dart';
import 'space.dart';
import 'toggle.dart';

class PanelHeader extends StatelessWidget {
  const PanelHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: tw(),
      children: [
        UserDp(menu: userMenu()),
        Expanded(child: SpaceName()),
        PanelToggle(),
      ],
    );
  }
}
