import 'package:flutter/material.dart';

import '../../../../_theme/spacing.dart';
import '../../../../_widgets/buttons/action.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/forms/input.dart';
import '../../../_helpers/forms/form_validation_helper.dart';
import '../_helpers/share.dart';
import '../var/var.dart';

Future<dynamic> showAddSharedMemberDialog([String? groupId, String? groupName]) {
  final TextEditingController emailsController = TextEditingController(text: groupName);

  return showAppDialog(
    title: 'Add Member',
    content: Form(
      key: emailFormKey,
      child: DataInput(
        hintText: 'Email',
        controller: emailsController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) => Validator.validateEmail(email: value!),
        autofocus: true,
        showBorder: true,
        margin: padS(),
        onFieldSubmitted: (_) async => await addSharedMember(emailsController.text.trim()),
      ),
    ),
    actions: [
      ActionButton(isCancel: true),
      ActionButton(
        label: 'Add',
        onPressed: (() async => await addSharedMember(emailsController.text.trim())),
      ),
    ],
  );
}
