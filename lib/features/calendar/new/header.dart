import 'package:flutter/material.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_services/cloud/sync/create_item.dart';
import '../../../_services/cloud/sync/edit_item.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/buttons/action.dart';
import '../_helpers/helpers.dart';
import 'color.dart';
import 'type.dart';

class NewSessionHeader extends StatelessWidget {
  const NewSessionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    bool isNew = state.input.item.isNew;

    return Row(
      children: [
        //
        TypePicker(),
        tpw(),
        SessionColor(),
        Spacer(),
        ActionButton(isCancel: true),
        ActionButton(
          onPressed: () {
            hideKeyboard();
            removeDuplicateSessionReminders();
            closeDialog();
            state.input.item.id = state.input.item.start().datePart();
            isNew ? createItem() : editItem();
          },
          label: isNew ? 'Create' : 'Save',
        ),
        //
      ],
    );
  }
}
