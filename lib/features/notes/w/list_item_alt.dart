import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../_models/item.dart';
import '../../../_services/hive/store.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/colors.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/prepare.dart';
import '../actions/actions.dart';
import '../state/active.dart';

class ListItemAlternate extends StatelessWidget {
  const ListItemAlternate({super.key, this.id = ''});
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

          return Consumer<DocProvider>(builder: (context, doc, child) {
            bool isSelected = doc.item.id == id;

            return Planet(
              onPressed: () => chooseNote(item),
              onEnter: (_) => state.focus.set(item.id),
              onExit: (_) => state.focus.reset(),
              blurred: isImage(),
              noStyling: !isSelected,
              padding: padC('l9,r5,t3,b3'),
              minHeight: 30,
              child: isLoading
                  ? SizedBox(height: 25, width: double.maxFinite)
                  : Row(
                      children: [
                        //icon
                        AppIcon(
                          item.typee().icon(),
                          size: mediumSmall,
                          color: item.hasColor() ? backgroundColors[item.color()]!.color : null,
                          mildFaded: true,
                          padding: padM('r'),
                        ),
                        // title
                        Expanded(
                          child: AppText(
                            size: mediumSmall,
                            item.title(),
                            mildFaded: true,
                            padding: padS('r'),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // options
                        ItemActions(doc: item, isPersistent: isSelected),
                        //
                      ],
                    ),
            );
          });
        });
  }
}
