import 'package:flutter/material.dart';

import '../../_models/item.dart';
import '../../_services/cloud/sync/delete_item.dart';
import '../../_state/_providers.dart';
import '../../_theme/variables.dart';
import '../../_widgets/_widgets.dart';
import '../../_widgets/menu/model.dart';

class QuickTaskActions extends StatelessWidget {
  const QuickTaskActions({
    super.key,
    required this.taskEntry,
    required this.onEditStart,
  });

  final Item taskEntry;
  final Function() onEditStart;

  @override
  Widget build(BuildContext context) {
    return Planet(
      menu: Menu(items: [
        //
        MenuItem(
          label: 'Edit',
          leading: editIcon,
          onTap: () {
            state.input.set(taskEntry);
            onEditStart();
          },
        ),
        //
        MenuItem(
          label: 'Delete',
          leading: deleteIcon,
          onTap: () => deleteItemForever(taskEntry),
        ),
        //
      ]),
      isSquare: true,
      noStyling: true,
      width: 28,
      height: 28,
      child: AppIcon(moreIcon, size: medium, extraFaded: true),
    );
  }
}
