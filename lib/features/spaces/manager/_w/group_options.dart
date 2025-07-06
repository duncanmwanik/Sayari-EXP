import 'package:flutter/material.dart';

import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/menu/confirmation.dart';
import '../../../../_widgets/menu/menu_item.dart';
import '../../../../_widgets/menu/model.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../user/_helpers/actions.dart';
import 'create_group.dart';

class GroupOptions extends StatelessWidget {
  const GroupOptions(this.groupid, this.groupName, {super.key});

  final String groupid;
  final String groupName;

  @override
  Widget build(BuildContext context) {
    return Planet(
      tooltip: 'Options',
      menu: Menu(
        items: [
          //
          MenuItem(
            label: 'Rename Group',
            leading: Icons.folder_delete_rounded,
            onTap: () => showCreateGroupDialog(groupid, groupName),
          ),
          //
          MenuItem(
            label: 'Delete Group',
            leading: Icons.folder_delete_rounded,
            menu: confirmationMenu(
              title: 'Delete group: $groupName?',
              yeslabel: 'Delete',
              onAccept: () => deleteGroup(groupid),
            ),
          ),
          //
        ],
      ),
      noStyling: true,
      isSquare: true,
      child: AppIcon(moreIcon, extraFaded: true, size: 18),
    );
  }
}
