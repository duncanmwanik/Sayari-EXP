import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/images.dart';
import 'emoji_menu.dart';

class Emoji extends StatelessWidget {
  const Emoji({
    super.key,
    required this.doc,
    required this.onSelect,
    required this.onRemove,
  });

  final Item doc;
  final Function(String emoji) onSelect;
  final Function() onRemove;

  @override
  Widget build(BuildContext context) {
    return Planet(
      menu: emojiMenu(onSelect: onSelect, onRemove: onRemove),
      isSquare: true,
      noStyling: true,
      margin: padS('r'),
      padding: padS(),
      child: doc.hasEmoji()
          ? AppImage('assets/emojis/${doc.emoji()}.png', size: normal)
          : AppIcon(Icons.checklist, size: extra, extraFaded: true),
    );
  }
}
