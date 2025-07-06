import 'package:flutter/material.dart';

import '../../../../_theme/spacing.dart';
import '../../../../_widgets/buttons/action.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/forms/input.dart';
import '../_helpers/edit_username.dart';
import '../_helpers/helpers.dart';

Future<dynamic> showEditUsernameDialog() {
  final TextEditingController nameController = TextEditingController(text: liveUserName());

  return showAppDialog(
    title: 'Change your name',
    content: DataInput(
      hintText: 'Your Name',
      controller: nameController,
      keyboardType: TextInputType.name,
      autofocus: true,
      showBorder: true,
      margin: padS(),
    ),
    actions: [
      ActionButton(isCancel: true),
      ActionButton(
        label: 'Change',
        onPressed: (() async => await editUsername(nameController.text.trim())),
      ),
    ],
  );
}
