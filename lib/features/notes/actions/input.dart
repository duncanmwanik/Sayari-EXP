import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/color.dart';
import '../../../_widgets/others/color_menu.dart';
import '../../../_widgets/others/icons.dart';
import '../../finance/_w_graphs/sheet.dart';
import '../../tags/menu.dart';
import '../w/emoji_menu.dart';
import 'input_more.dart';

class CommonInputActions extends StatelessWidget {
  const CommonInputActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool isPinned = input.item.isPinned();

      return Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: sw(),
        runSpacing: sw(),
        children: [
          //
          ColorButton(
            menu: colorMenu(
              selectedColor: input.item.color(),
              onSelect: (newColor) => input.update('c', newColor),
            ),
            color: input.item.color(),
          ),
          //
          Planet(
            menu: emojiMenu(
              onSelect: (emoji) => input.update(itemEmoji, emoji),
              onRemove: () => input.remove(itemEmoji),
            ),
            tooltip: 'Emoji',
            noStyling: true,
            isSquare: true,
            child: AppIcon(emojiIcon, size: normal, faded: true),
          ),
          //
          Planet(
            onPressed: () => isPinned ? input.remove(itemPinned) : input.update(itemPinned, 1),
            tooltip: isPinned ? 'Unpin' : 'Pin',
            noStyling: true,
            isSquare: true,
            child: AppIcon(pinIcon, size: normal, faded: true, rotation: isPinned ? 30 : 0),
          ),
          //
          Planet(
            tooltip: 'Tags',
            noStyling: true,
            isSquare: true,
            menu: tagsMenu(
              doc: input.item,
              isSelection: true,
              onUpdate: (newTags) => newTags.isEmpty ? input.remove(itemTags) : input.update(itemTags, newTags),
            ),
            child: AppIcon(tagIcon, size: normal, faded: true),
          ),
          //
          if (input.item.isFinance())
            Planet(
              onPressed: () => showFinanceGraphsBottomSheet(),
              tooltip: 'Graphs',
              noStyling: true,
              isSquare: true,
              child: AppIcon(graphIcon, size: normal, faded: true),
            ),
          //
          MoreInputActions(),
          //
        ],
      );
    });
  }
}
