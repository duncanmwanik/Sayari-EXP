import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

import '../../../_models/item.dart';
import '../../../_theme/spacing.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/rebuilders/length_type.dart';
import '../../notes/_helpers/order.dart';
import 'task.dart';

class KanbanListItems extends StatelessWidget {
  const KanbanListItems({super.key, required this.list});

  final Item list;

  @override
  Widget build(BuildContext context) {
    return LengthRebuilderType(
      types: [features.kanban],
      id: list.id,
      builder: () {
        List subItemsKeys = list.subKeys();
        if (list.showNewEntriesFirst()) {
          subItemsKeys = subItemsKeys.reversed.toList();
        }

        return Padding(
          padding: padM('t'),
          child: ReorderableWrap(
            key: UniqueKey(),
            runSpacing: th(),
            maxMainAxisCount: 1,
            padding: EdgeInsets.zero,
            needsLongPressDraggable: false,
            onReorder: (oldIndex, newIndex) => orderSubItem(
              itemId: list.id,
              oldItemId: subItemsKeys[oldIndex],
              newItemId: subItemsKeys[newIndex],
              itemsLength: subItemsKeys.length,
              oldIndex: oldIndex,
              newIndex: newIndex,
            ),
            children: List.generate(subItemsKeys.length, (index) {
              return KanbanListItem(
                task: Item(
                  parent: features.docs,
                  id: list.id,
                  sid: subItemsKeys[index],
                  data: list.data[subItemsKeys[index]],
                ),
                showChecks: list.temp,
              );
            }),
          ),
        );
      },
    );
  }
}


// return Draggable(
//   data: sitem,
//   dragAnchorStrategy: pointerDragAnchorStrategy,
//   feedback: SubItem(sitem: sitem, item: item),
//   child: SubItem(sitem: sitem, item: item),
// );