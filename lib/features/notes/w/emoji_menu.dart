import 'package:flutter/material.dart';

import '../../../_helpers/nav/navigation.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/emojis.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/menu/model.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/images.dart';

Menu emojiMenu({required Function(String emoji) onSelect, required Function() onRemove}) {
  return Menu(
    items: [
      //
      Wrap(
        spacing: tw(),
        runSpacing: tw(),
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          //
          MenuItem(label: 'Choose emoji', faded: true, sh: true, popTrailing: true),
          menuDivider(), ph(1),
          //
          Planet(
            onPressed: () {
              popWhatsOnTop(); // close menu
              onRemove();
            },
            width: 30,
            height: 30,
            color: styler.appColor(1),
            isSquare: true,
            child: AppIcon(Icons.clear, size: 15, faded: true),
          ),
          //
          for (String emoji in emojis)
            Planet(
              onPressed: () {
                popWhatsOnTop(); // close menu
                onSelect(emoji);
              },
              width: 30,
              height: 30,
              noStyling: true,
              isSquare: true,
              child: AppImage('assets/emojis/$emoji.png', size: 20),
            )
          //
          //
        ],
      )
      //
    ],
  );
}
