import 'package:flutter/material.dart';

import '../../../_helpers/common/clipboard.dart';
import '../../../_models/item.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/menu/model.dart';
import '../../spaces/_helpers/common.dart';
import '../_helpers/delete.dart';
import '../_helpers/helpers.dart';

Menu chatMenu(Item item) {
  return Menu(
    items: [
      // MenuItem(label: QuillController.basic().g)
      //
      // if (isAdmin())
      // MenuItem(
      //   onTap: () {},
      //   label: 'Edit',
      //   leading: editIcon_rounded,
      // ),
      //
      MenuItem(
        onTap: () => copyText(item.data[itemContent], toast: false),
        label: 'Copy Text',
        leading: Icons.copy_rounded,
      ),
      //
      if (isAdmin())
        MenuItem(
          onTap: () => item.isPinned() ? unPinMessage(item) : pinMessage(item),
          label: item.isPinned() ? 'Unpin' : 'Pin',
          leading: item.isPinned() ? Icons.push_pin : Icons.push_pin_outlined,
        ),
      //
      // if (isAdmin())
      //   MenuItem(
      //     onTap: () {},
      //     label: item.isPinned() ? 'Unstar' : 'Star',
      //     leading: item.isPinned() ? Icons.star : Icons.star_outline,
      //   ),
      //
      menuDivider(),
      //
      if (isAdmin())
        MenuItem(
          onTap: () => deleteMessage(item),
          label: 'Delete For Me',
          leading: Icons.delete_rounded,
        ),
      if (isAdmin())
        MenuItem(
          onTap: () => deleteMessage(item, forAll: true),
          label: 'Delete For All',
          leading: Icons.delete_rounded,
        ),
      //
    ],
  );
}
