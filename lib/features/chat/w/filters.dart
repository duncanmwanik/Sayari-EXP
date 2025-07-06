import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/text.dart';
import '../state/chat.dart';

class ChatFilters extends StatelessWidget {
  const ChatFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chat, child) {
      return Planet(
        padding: noPadding,
        noStyling: true,
        showBorder: true,
        child: Row(
          children: [
            for (String type in ['All', 'Pinned', 'Starred'])
              Expanded(
                child: Planet(
                  onPressed: () => chat.setType(type),
                  svp: true,
                  noStyling: chat.type != type,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // AppIcon(Icons.star_border_outlined, size: medium, faded: true),
                      // tpw(),
                      Flexible(child: AppText(type, faded: true)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
