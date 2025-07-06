import 'package:flutter/material.dart';

import '../../../_helpers/nav/navigation.dart';
import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/menu/confirmation.dart';
import '../../../_widgets/others/icons.dart';

class DeleteItem extends StatelessWidget {
  const DeleteItem({super.key, required this.task});
  final Item task;

  @override
  Widget build(BuildContext context) {
    return Planet(
      menu: confirmationMenu(
        title: 'Delete task?',
        onAccept: () => popWhatsOnTop(todo: () => state.input.remove(parentKey: task.id, task.sid)),
      ),
      isSquare: true,
      noStyling: true,
      color: styler.appColor(0.8),
      child: AppIcon(Icons.delete, color: red, size: 16),
    );
  }
}
