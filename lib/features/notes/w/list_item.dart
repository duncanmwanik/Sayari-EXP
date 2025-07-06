import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../_models/item.dart';
import '../../../_services/hive/store.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/ontap.dart';
import '../_helpers/prepare.dart';
import '../actions/actions.dart';
import '../state/selection.dart';
import 'pinned.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, this.id = ''});
  final String id;

  @override
  Widget build(BuildContext context) {
    bool isLoading = id.isEmpty;

    return ValueListenableBuilder(
        valueListenable: local(features.docs).listenable(keys: [id]),
        builder: (context, box, wgt) {
          Item item = Item(
            parent: features.docs,
            id: id,
            data: local(features.docs).get(id, defaultValue: {}),
          );

          return Consumer<SelectionProvider>(builder: (_, selection, __) {
            bool isSelection = selection.isSelection;
            bool isSelected = selection.isSelected(item.id);

            return Planet(
              onPressed: () => editNote(item),
              onLongPress: isSelected || (item.isKanban() && !isSelection) ? null : () => onLongPressNote(item),
              blurred: isImage(),
              showBorder: true,
              borderWidth: 0.2,
              color: styler.getItemColor(),
              hoverColor: styler.appColor(0.5),
              padding: padC('l10,r6,t6,b6'),
              child: isLoading
                  ? SizedBox(height: 28, width: double.maxFinite)
                  : Row(
                      children: [
                        // color
                        Planet(
                          padding: noPadding,
                          margin: padN('r'),
                          child: AppIcon(
                            Icons.circle,
                            size: small,
                            color: item.hasColor() ? styler.getItemBgColor(item.color(), true) : styler.appColor(2),
                          ),
                        ),
                        // title
                        Expanded(
                          child: AppText(size: medium, item.title()),
                        ),
                        // pinned
                        if (item.isPinned()) PinnedIcon(doc: item),
                        // options
                        ItemActions(doc: item, isPersistent: true),
                        //
                      ],
                    ),
            );
          });
        });
  }
}
