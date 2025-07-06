import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

import '../../../_theme/spacing.dart';
import '../../_models/item.dart';
import '../../_state/_providers.dart';
import '../../_theme/breakpoints.dart';
import '../../_theme/variables.dart';
import '../../_widgets/others/snap_scroll_physics.dart';
import 'list.dart';
import 'var/var.dart';

class KanbanLists extends StatelessWidget {
  const KanbanLists({
    super.key,
    required this.listIds,
    this.doc,
    this.isLoading = false,
  });

  final List listIds;
  final Item? doc;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    bool isInput = doc == null;
    Item doc_ = doc ?? state.input.item;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: isInput ? null : padL('lt'),
      physics: isSmallPC() ? null : const SnapScrollPhysics(snapSize: 300),
      child: Transform.scale(
        alignment: Alignment.topLeft,
        scale: isInput ? 1 : 0.8,
        child: ReorderableRow(
          scrollController: kanbanScrollController,
          ignorePrimaryScrollController: true,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          onReorder: (oldIndex, newIndex) {},
          children: List.generate(isLoading ? 3 : listIds.length, (index) {
            String listId = isLoading ? '' : listIds[index];

            return ReorderableDelayedDragStartListener(
              index: isLoading ? Random().nextInt(1000) : index,
              key: ValueKey(isLoading ? null : listIds[index]),
              enabled: false,
              child: Padding(
                padding: index == 0 ? noPadding : padL('l'),
                child: KanbanList(
                  list: Item(
                    isInput: isInput,
                    id: listId,
                    temp: doc_.showChecks(),
                    data: isLoading ? {} : doc_.data[listIds[index]],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
