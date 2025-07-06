import 'package:flutter/material.dart';

import '../../../_helpers/nav/navigation.dart';
import '../../../_models/item.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/menu/confirmation.dart';
import '../../../_widgets/others/icons.dart';
import '../_helpers/delete.dart';
import '../_helpers/prepare.dart';

class SessionActions extends StatelessWidget {
  const SessionActions({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: sw(),
      runSpacing: sw(),
      alignment: WrapAlignment.end,
      children: [
        //
        Planet(
          onPressed: () => popWhatsOnTop(todoLast: () => editSession(item)),
          tooltip: 'Edit Session',
          noStyling: true,
          isSquare: true,
          child: AppIcon(editIcon, faded: true, size: 18),
        ),
        //
        Planet(
          onPressed: () => popWhatsOnTop(todoLast: () => createSession(item: item)),
          tooltip: 'Duplicate',
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.copy_rounded, faded: true, size: 18),
        ),
        //
        Planet(
          menu: confirmationMenu(
            title: 'Delete session: ${item.title()}?',
            onAccept: () => deleteSession(item: item),
          ),
          tooltip: 'Delete',
          noStyling: true,
          isSquare: true,
          child: AppIcon(Icons.delete, faded: true, size: 18),
        ),
        //
      ],
    );
  }
}
