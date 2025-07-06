import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../_helpers/common/global.dart';
import '../../../_helpers/extentions/strings.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/_widgets.dart';
import '../../../_widgets/others/divider_vertical.dart';

Future showAddSocialDialog(Item social) {
  TextEditingController linkController = TextEditingController(text: social.content());

  return showAppDialog(
    //
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppImage('sayari.png', size: extra),
        spw(),
        AppText(social.title().cap()),
      ],
    ),
    //
    content: Padding(
      padding: padM('tb'),
      child: DataInput(
        controller: linkController,
        hintText: 'Link',
        autofocus: true,
        showBorder: true,
      ),
    ),
    //
    actions: [
      if (!social.isNew)
        ActionButton(
          isCancel: true,
          label: 'Remove',
          onPressed: () {
            state.input.remove(social.id);
            closeDialog();
          },
        ),
      if (!social.isNew) AppSeparator(padding: padC('t12,b12,l6,r6')),
      ActionButton(isCancel: true),
      ActionButton(
        label: social.isNew ? 'Add' : 'Save',
        onPressed: () {
          if (linkController.text.trim().isNotEmpty) {
            state.input.update(
              social.isNew ? '$itemSubItem${getUniqueId()}' : social.id,
              {
                itemTitle: social.title(),
                itemContent: linkController.text.trim(),
                itemType: itemLinkTypeSocial,
              },
            );
            closeDialog();
          } else {
            toastError("Link can't be empty.");
          }
        },
      ),
    ],
  );
}
