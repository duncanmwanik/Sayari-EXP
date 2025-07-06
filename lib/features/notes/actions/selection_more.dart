import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_services/cloud/sync/quick_edit.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/menu/model.dart';
import '../../../_widgets/others/icons.dart';
import '../state/selection.dart';

class ItemSelectionMore extends StatelessWidget {
  const ItemSelectionMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionProvider>(builder: (context, selection, child) {
      bool isArchive = state.views.tag == 'Archive';

      return Planet(
        tooltip: 'More',
        menu: Menu(
          items: [
            //
            MenuItem(
              label: isArchive ? 'Unarchive' : 'Archive',
              leading: isArchive ? unarchiveIcon : archiveIcon,
              onTap: () async {
                if (isArchive) {
                  selection.selected.forEach((item) async {
                    await quickEdit(action: 'd', parent: item.parent, id: item.id, key: itemArchived);
                  });
                } else {
                  selection.selected.forEach((item) async {
                    await quickEdit(parent: item.parent, id: item.id, key: itemArchived, value: 1);
                  });
                }
                state.selection.clear();
              },
            ),
            //
            MenuItem(
              label: 'Move To Trash',
              leading: deleteIcon,
              onTap: () async {
                selection.selected.forEach((item) async {
                  await quickEdit(parent: item.parent, id: item.id, key: itemTrashed, value: 1);
                });
                state.selection.clear();
              },
            ),
            //
          ],
        ),
        noStyling: true,
        child: AppIcon(moreIcon, faded: true),
      );
    });
  }
}
