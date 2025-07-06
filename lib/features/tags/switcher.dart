import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_helpers/common/global.dart';
import '../../_state/views.dart';
import '../../_theme/colors.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import 'menu.dart';
import 'var/tag_model.dart';

class TagSwitcher extends StatelessWidget {
  const TagSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(builder: (context, views, child) {
      Tag selectedTag = Tag(id: views.tag);
      bool isAlternate = views.isAlternateView();

      return Planet(
        menu: tagsMenu(
          onUpdate: (newTags) => newTags.isNotEmpty ? views.updateSelectedTag(splitList(newTags).first) : null,
        ),
        margin: isAlternate ? noPadding : padM('r'),
        padding: padC('l6,r4,t3,b3'),
        noStyling: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(
              tagIcon,
              size: medium,
              faded: true,
              color: selectedTag.hasColor() ? backgroundColors[selectedTag.color()]!.color : null,
              padding: padMS('r'),
            ),
            Flexible(
              child: AppText(
                selectedTag.name(),
                maxlines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
            tpw(),
            AppIcon(Icons.keyboard_arrow_down, size: normal, faded: true),
          ],
        ),
      );
    });
  }
}
