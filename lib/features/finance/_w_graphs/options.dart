import 'package:flutter/material.dart';

import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/menu/model.dart';

Menu graphMenu() {
  return Menu(items: [
    MenuItem(leading: Icons.share_rounded, label: 'Save as image', onTap: () {}),
    MenuItem(leading: Icons.share_rounded, label: 'Save as PDF', onTap: () {}),
  ]);
}
