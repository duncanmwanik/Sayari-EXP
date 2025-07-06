import 'package:flutter/material.dart';

import '../../../../_theme/spacing.dart';
import '../../../../_widgets/buttons/action.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/forms/input.dart';
import '../../../user/_helpers/actions.dart';

Future<dynamic> showCreateGroupDialog([String? groupId, String? groupName]) {
  final TextEditingController nameController = TextEditingController(text: groupName);

  return showAppDialog(
    title: groupId != null ? 'Rename Group' : 'Create Group',
    content: DataInput(
      hintText: 'Name',
      controller: nameController,
      keyboardType: TextInputType.name,
      autofocus: true,
      margin: padS(),
      onFieldSubmitted: (_) async => await createGroup(nameController.text.trim(), groupId: groupId),
    ),
    actions: [
      ActionButton(isCancel: true),
      ActionButton(
        label: 'Create',
        onPressed: (() async => await createGroup(nameController.text.trim(), groupId: groupId)),
      ),
    ],
  );
}
