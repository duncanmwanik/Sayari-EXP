import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/nav/navigation.dart';
import '../../../_models/item.dart';
import '../../../_services/cloud/sync/edit_item.dart';
import '../../../_state/_providers.dart';
import '../../../_state/input2.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/action.dart';
import '../../../_widgets/dialogs/app_dialog.dart';
import '../../../_widgets/files/file_list.dart';
import '../../../_widgets/forms/input.dart';
import '../../reminders/reminder.dart';
import '../../spaces/_helpers/common.dart';
import '../_helpers/helper.dart';
import 'actions.dart';
import 'flags.dart';

Future<void> showItemDialog(Item task) async {
  state.input2.set(task);

  await showAppDialog(
    content: Consumer<InputProvider2>(builder: (context, input, child) {
      return ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: noPadding,
        children: [
          // title
          DataInput(
            onChanged: (value) => state.input2.update(itemTitle, value.trim(), notify: true),
            inputKey: itemTitle,
            initialValue: task.title(),
            hintText: 'Task',
            onTapOutside: (_) => removeFocus(),
            onFieldSubmitted: (_) => editItem(),
            textInputAction: TextInputAction.done,
            enabled: isAdmin(),
            minLines: 2,
            autofocus: true,
            color: styler.appColor(0.3),
            hoverColor: transparent,
          ),
          //
          sph(),
          // actions
          if (isAdmin()) SubItemActions(task: task),
          mph(),

          // reminder
          if (input.item.hasReminder())
            Align(
              alignment: Alignment.centerLeft,
              child: Reminder(item: input.item),
            ),
          if (input.item.hasReminder() && input.item.hasFlags()) sph(),
          // flags
          ItemFlagList(flagList: input.item.flags()),
          // files
          Padding(padding: padN('t'), child: FileList(item: input.item)),
          elph(),
          //
        ],
      );
    }),
    //
    actions: [
      Consumer<InputProvider2>(builder: (context, input, child) {
        bool edited = !DeepCollectionEquality().equals(input.item.data, input.previousData) && input.item.hasTitle();

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ActionButton(label: edited ? 'Cancel' : 'Close', isCancel: true),
            ActionButton(onPressed: () => editSubItem(input.item), label: 'Save', enabled: edited),
          ],
        );
      }),
      //
    ],
    //
  );
}
