import 'package:flutter/material.dart';

import '../../../_variables/features.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../_helpers/prepare.dart';

List<Widget> templatesMenu() {
  return [
    //
    // MenuItem(label: '...', faded: true, sh: true, popTrailing: true),
    // menuDivider(),
    MenuItem(label: 'Habit', leading: Icons.hourglass_full, onTap: () => createDoc(features.habits)),
    MenuItem(label: 'Finance', leading: Icons.attach_money, onTap: () => createDoc(features.finances)),
    MenuItem(label: 'Links', leading: Icons.link_sharp, onTap: () => createDoc(features.links)),
    MenuItem(label: 'Booking', leading: Icons.calendar_month, onTap: () => createDoc(features.bookings)),
    // MenuItem(label: 'Portfolio', leading: Icons.workspace_premium, onTap: () => createDoc(features.portfolios)),
    //
  ];
}
