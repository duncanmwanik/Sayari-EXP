import 'package:flutter/material.dart';

import '../../../_variables/features.dart';
import '../../../_widgets/menu/menu_item.dart';
import 'pinned_option.dart';

List<Widget> pinnedNavOptions() {
  return [
    // workspace
    MenuItem(label: 'Space', faded: true),
    PinnedNavOption(type: features.chat),
    //
    menuDivider(),
    // user
    MenuItem(label: 'User', faded: true),
    // PinnedNavOption(type: features.explore),
    //
  ];
}
