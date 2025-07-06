import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../_models/item.dart';
import '../../../_services/cloud/sync/quick_edit.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/ontap.dart';
import '../actions/actions.dart';
import 'emoji.dart';
import 'pinned.dart';

class DocTitle extends StatelessWidget {
  const DocTitle({super.key, required this.doc});

  final Item doc;

  @override
  Widget build(BuildContext context) {
    return Planet(
      onPressed: () => onTapNote(doc),
      onLongPress: state.selection.isSelected(doc.id) ? null : () => onLongPressNote(doc),
      noStyling: true,
      padding: noPadding,
      hoverColor: transparent,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadiusTinySmall),
        topRight: Radius.circular(borderRadiusTinySmall),
      ),
      child: Stack(
        children: [
          // header
          Planet(
            noStyling: true,
            color: isLight() ? white : styler.appColor(0.2),
            padding: padC(doc.hasEmoji() ? 'l5,r3,t3,b3' : 'l8,r3,t3,b3'),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadiusTinySmall),
              topRight: Radius.circular(borderRadiusTinySmall),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // emoji
                if (doc.hasEmoji())
                  Emoji(
                    doc: doc,
                    onSelect: (emoji) => quickEdit(parent: doc.parent, id: doc.id, key: itemEmoji, value: emoji),
                    onRemove: () => quickEdit(action: 'd', parent: doc.parent, id: doc.id, key: itemEmoji),
                  ),
                // title
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: AppText(
                    size: kIsWeb ? mediumSmall : small,
                    doc.title(),
                    faded: !doc.hasTitle(),
                    maxlines: 2,
                    weight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
                //
                if (doc.isPinned()) PinnedIcon(doc: doc),
                //
                ItemActions(doc: doc, isPersistent: true),
                //
              ],
            ).animate().fadeIn(),
          ),
          //
        ],
      ),
    );
  }
}
