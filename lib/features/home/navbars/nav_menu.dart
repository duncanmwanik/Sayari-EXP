import 'package:flutter/material.dart';

import '../../../_variables/features.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/menu/model.dart';
import '../_helpers/go_to_view.dart';

Menu navMenu() {
  return Menu(
    items: [
      MenuItem(label: 'Chat', leading: Icons.message_rounded, onTap: () => goToView(features.chat)),
    ],
  );
}
