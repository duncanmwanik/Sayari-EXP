import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../_helpers/common/helpers.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/spacing.dart';
import '../_helpers/misc.dart';
import '../_helpers/order.dart';
import '../note.dart';
import '../w/list_item.dart';
import '../w/list_item_alt.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({
    super.key,
    required this.ids,
    this.isLoading = false,
  });
  final List ids;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    bool isAlternate = state.views.isAlternateView();

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return SizedBox(
        width: double.maxFinite,
        child: ReorderableWrap(
          alignment: state.views.isRow() ? WrapAlignment.center : WrapAlignment.start,
          key: UniqueKey(),
          enableReorder: !isShare(),
          ignorePrimaryScrollController: true,
          spacing: isSmallPC() ? 12 : 2.w,
          runSpacing: isAlternate ? 1 : (state.views.isList() ? 6 : 12),
          maxMainAxisCount: state.views.isGrid() ? null : 1,
          padding: isAlternate
              ? null
              : pad(
                  l: isMediumPC() ? elh() : null,
                  r: isMediumPC() ? elh() : null,
                  t: isMediumPC() ? elh() : null,
                  b: h10(),
                ),
          onReorder: (oldIndex, newIndex) => orderItems(
            oldItemId: ids[oldIndex],
            newItemId: ids[newIndex],
            itemsLength: ids.length,
            oldIndex: oldIndex,
            newIndex: newIndex,
          ),
          children: List.generate(isLoading ? getItemCount() : ids.length, (index) {
            return isAlternate
                ? ListItemAlternate(
                    key: isLoading ? null : Key(ids[index]),
                    id: isLoading ? '' : ids[index],
                  )
                : state.views.isList()
                    ? ListItem(
                        key: isLoading ? null : Key(ids[index]),
                        id: isLoading ? '' : ids[index],
                      )
                    : Note(
                        key: isLoading ? null : Key(ids[index]),
                        id: isLoading ? '' : ids[index],
                      );
          }),
        ),
      );
    });
  }
}
