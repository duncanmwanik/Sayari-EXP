import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../../_state/_providers.dart';
import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/rebuilders/rebuild.dart';
import 'link_item.dart';

class LinksList extends StatelessWidget {
  const LinksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return InputRebuilder(
        itemKey: itemLinksOrder,
        builder: (value) {
          List linkKeys = state.input.item.sharedlinks();

          return Padding(
            padding: padL('t'),
            child: ReorderableWrap(
              key: UniqueKey(),
              maxMainAxisCount: 1,
              padding: EdgeInsets.zero,
              onReorder: (oldIndex, newIndex) {
                // fix
                if (newIndex > linkKeys.length) newIndex = linkKeys.length;
                if (oldIndex < newIndex) newIndex--;
                //
                //  String orderedId = linkKeys.removeAt(oldIndex);
                //  state.input.update(itemLinksOrder, joinList(links));
              },
              children: List.generate(linkKeys.length, (index) {
                return LinkItem(index: index, id: linkKeys[index]);
              }),
            ),
          );
        },
      );
    });
  }
}
