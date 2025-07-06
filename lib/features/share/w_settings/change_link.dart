import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/_widgets.dart';
import '../_helpers/link.dart';

Future showChangeLinkDialog() {
  String link = state.input.item.customLink().isNotEmpty ? state.input.item.customLink() : state.input.item.sharedLink();
  TextEditingController linkController = TextEditingController(
    text: link.replaceAll('$sayariDefaultPath/', ''),
  );

  return showAppDialog(
    //
    title: AppText('Custom Link'),
    //
    content: Row(
      children: [
        AppText('/', size: extra, extraFaded: true),
        tpw(),
        Expanded(
          child: DataInput(
            controller: linkController,
            hintText: 'Custom Link',
            autofocus: true,
            showBorder: true,
            maxLines: 1,
            // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^A-Za-z0-9_'))],
            // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
          ),
        ),
      ],
    ),
    //
    actions: [
      ActionButton(isCancel: true),
      ActionButton(
        label: 'Save',
        onPressed: () async => changeCustomLink(linkController.text.trim()),
      ),
    ],
  );
}
