import 'package:flutter/material.dart';

import '../../_models/item.dart';
import '../../_state/_providers.dart';
import '../../_theme/variables.dart';
import '../../_widgets/_widgets.dart';
import '../../_widgets/menu/model.dart';

class ListActions extends StatelessWidget {
  const ListActions({super.key, required this.list});
  final Item list;

  @override
  Widget build(BuildContext context) {
    return Planet(
      menu: Menu(
        items: [
          MenuItem(
            label: 'Remove List',
            leading: deleteIcon,
            menu: confirmationMenu(
              title: 'Delete list?',
              onAccept: () => state.input.remove(list.id),
            ),
          ),
        ],
      ),
      isSquare: true,
      noStyling: true,
      child: AppIcon(moreIcon, size: normal, extraFaded: true),
    );
  }
}
