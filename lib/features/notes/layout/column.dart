import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

import '../../../_theme/breakpoints.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/others/snap_scroll_physics.dart';
import '../_helpers/misc.dart';
import '../_helpers/order.dart';
import '../note.dart';

class ColumnLayout extends StatelessWidget {
  const ColumnLayout({
    super.key,
    required this.ids,
    this.isLoading = false,
  });
  final List ids;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: pad(
        t: isSmallPC() ? elh() : null,
        l: isSmallPC() ? elh() : null,
        r: 250 / 2,
        b: isSmallPC() ? null : h10(),
      ),
      physics: kIsWeb ? null : const SnapScrollPhysics(snapSize: 300),
      child: ReorderableRow(
        ignorePrimaryScrollController: true,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        onReorder: (oldIndex, newIndex) => orderItems(
          oldItemId: ids[oldIndex],
          newItemId: ids[newIndex],
          itemsLength: ids.length,
          oldIndex: oldIndex,
          newIndex: newIndex,
        ),
        children: List.generate(isLoading ? getItemCount() : ids.length, (index) {
          return ReorderableDelayedDragStartListener(
            index: isLoading ? Random().nextInt(1000) : index,
            key: ValueKey(isLoading ? null : ids[index]),
            child: Padding(
              padding: EdgeInsets.only(left: index == 0 ? 0 : msw()), // spaces between items
              child: Note(id: isLoading ? '' : ids[index]),
            ),
          );
        }),
      ),
    );
  }
}
