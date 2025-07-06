import 'package:flutter/material.dart';

import '../../../../_helpers/nav/navigation.dart';
import '../../../../_services/hive/boxes.dart';
import '../../../../_theme/breakpoints.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_variables/constants.dart';
import '../../../../_widgets/_widgets.dart';
import '../../../../_widgets/menu/model.dart';
import '../../_helpers/prepare.dart';
import 'add_space.dart';
import 'create_group.dart';

class CreateOptions extends StatelessWidget {
  const CreateOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padC('b5'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          Planet(
            menu: Menu(
              items: [
                //
                MenuItem(
                  label: 'Create Space',
                  leading: Icons.add_rounded,
                  onTap: () => prepareSpaceForCreation(),
                ),
                //
                MenuItem(
                  label: 'Create Group',
                  leading: Icons.create_new_folder_rounded,
                  onTap: () => showCreateGroupDialog(),
                ),
                //
                MenuItem(
                  label: 'Add Space',
                  leading: Icons.add_circle_outline_rounded,
                  onTap: () => showAddSpaceDialog(),
                ),
                //
              ],
            ),
            slp: true,
            noStyling: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIcon(Icons.add_rounded, size: normal, color: styler.accent()),
                tpw(),
                AppText('Create'),
              ],
            ),
          ),
          //
          AppCloseButton(
            faded: true,
            onPressed: () {
              isSmallPC() ? globalBox.put(drawerType, panelItemsType) : popWhatsOnTop();
            },
          ),
          //
        ],
      ),
    );
  }
}
