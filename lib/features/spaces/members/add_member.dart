import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_widgets/buttons/action.dart';
import '../../../_widgets/dialogs/app_dialog.dart';
import '../../../_widgets/forms/input.dart';
import '../_helpers/members.dart';

Future showAddAdminDialog() {
  final TextEditingController emailController = TextEditingController();

  return showAppDialog(
    title: 'Enter user email',
    content: DataInput(
      hintText: 'Email',
      controller: emailController,
      keyboardType: TextInputType.text,
      autofocus: true,
      showBorder: true,
      margin: padM('tb'),
      onFieldSubmitted: ((_) async => await addMemberToSpace(emailController.text.trim())),
    ),
    actions: [
      ActionButton(isCancel: true),
      ActionButton(
        label: 'Add',
        onPressed: (() async => await addMemberToSpace(emailController.text.trim())),
      ),
    ],
  );
}
