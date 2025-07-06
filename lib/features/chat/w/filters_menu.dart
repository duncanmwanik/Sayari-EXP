import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/menu/model.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../state/chat.dart';

class ChatFiltersMenu extends StatelessWidget {
  const ChatFiltersMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chat, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Planet(
            menu: Menu(
              items: [
                MenuItem(label: 'All', leading: Icons.all_inclusive, onTap: () => chat.setType('All')),
                MenuItem(label: 'Pinned', leading: Icons.push_pin_outlined, onTap: () => chat.setType('Pinned')),
                MenuItem(label: 'Starred', leading: Icons.push_pin_outlined, onTap: () => chat.setType('Starred')),
              ],
            ),
            srp: true,
            margin: padM('r'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: AppText(chat.type)),
                tpw(),
                AppIcon(dropIcon),
              ],
            ),
          ),
        ],
      );
    });
  }
}
