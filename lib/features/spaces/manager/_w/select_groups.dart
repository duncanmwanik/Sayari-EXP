import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../_helpers/nav/navigation.dart';
import '../../../../_services/hive/boxes.dart';
import '../../../../_state/_providers.dart';
import '../../../../_state/temp.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_variables/constants.dart';
import '../../../../_widgets/buttons/action.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/others/checkbox.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import 'create_group.dart';

Future showSelectGroupsDialog() {
  return showAppDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText('Select groups'),
        Planet(
          onPressed: () => showCreateGroupDialog(),
          svp: true,
          slp: true,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(Icons.add, size: normal),
              tpw(),
              AppText('Create'),
            ],
          ),
        ),
      ],
    ),
    content: ValueListenableBuilder(
        valueListenable: userGroupsBox.listenable(),
        builder: (context, box, widget) {
          return box.isNotEmpty
              ? Wrap(
                  runSpacing: th(),
                  children: [
                    //
                    for (String groupId in box.keys)
                      Consumer<TempProvider>(
                          builder: (context, temp, child) => Planet(
                                onPressed: () => temp.updateList(groupId),
                                srp: true,
                                noStyling: true,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const AppIcon(Icons.folder_rounded, faded: true, size: 16),
                                    mpw(),
                                    Expanded(
                                      child: AppText(
                                        box.get(groupId, defaultValue: {})[itemTitle] ?? 'Untitled',
                                      ),
                                    ),
                                    spw(),
                                    AppCheckBox(
                                      isChecked: temp.tempList.contains(groupId),
                                      onTap: () => temp.updateList(groupId),
                                    ),
                                  ],
                                ),
                              )),
                    //
                  ],
                )
              : Align(
                  alignment: Alignment.center,
                  child: Planet(
                    onPressed: () => showCreateGroupDialog(),
                    noStyling: true,
                    child: const AppText('Tap to create your first group', faded: true),
                  ),
                );
        }),
    actions: [
      ActionButton(isCancel: true, onPressed: () => popWhatsOnTop(todo: () => state.temp.reset())),
      ActionButton(),
    ],
  );
}
