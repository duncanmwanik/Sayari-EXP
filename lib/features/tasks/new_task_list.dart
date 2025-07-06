import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_theme/spacing.dart';
import '../../../_widgets/buttons/action.dart';
import '../../../_widgets/dialogs/app_dialog.dart';
import '../../../_widgets/forms/input.dart';
import '../../_helpers/common/global.dart';
import '../../_helpers/nav/navigation.dart';
import '../../_models/item.dart';
import '../../_services/cloud/sync/create_item.dart';
import '../../_services/cloud/sync/edit_item.dart';
import '../../_state/_providers.dart';
import '../../_state/input.dart';
import '../../_variables/constants.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/color_picker.dart';

Future<dynamic> showCreateTaskListDialog({Item? taskList}) {
  bool isEdit = taskList != null;

  if (isEdit) {
    state.input.set(taskList);
  } else {
    state.input.set(Item(
      isNew: true,
      type: features.todo,
      parent: features.todo,
      id: getUniqueId(),
      data: {itemTimestamp: getUniqueId(), itemColor: '0'},
    ));
  }

  return showAppDialog(
    title: 'New To-Do List',
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        DataInput(
          hintText: 'Title',
          keyboardType: TextInputType.name,
          autofocus: true,
          showBorder: true,
          margin: padM('tb'),
          onFieldSubmitted: (_) => hideKeyboard(),
        ),
        //
        sph(),
        Consumer<InputProvider>(builder: (context, input, child) {
          return AppColorPicker(
            selectedColor: input.item.color(),
            showRemove: false,
            showNone: true,
            pop: false,
            onSelect: (newColor) => input.update(itemColor, newColor),
          );
        }),
        mph(),
        //
      ],
    ),
    actions: [
      ActionButton(isCancel: true),
      ActionButton(
        label: isEdit ? 'Save' : 'Create',
        onPressed: () => popWhatsOnTop(todoLast: () async => isEdit ? editItem(pop: true) : createItem(pop: true)),
      ),
    ],
  );
}
