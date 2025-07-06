import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../_models/item.dart';
import '../../_services/hive/store.dart';
import '../../_state/_providers.dart';
import '../../_theme/breakpoints.dart';
import '../../_theme/helpers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/planet.dart';
import '../bookings/_w_item/overview.dart';
import '../finance/overview.dart';
import '../habits/overview.dart';
import '../kanban/overview.dart';
import '../links/doc/overview.dart';
import '_helpers/ontap.dart';
import 'state/selection.dart';
import 'w/details.dart';
import 'w/doc_title.dart';
import 'w/overview.dart';

class Note extends StatelessWidget {
  const Note({super.key, this.id = ''});
  final String id;

  @override
  Widget build(BuildContext context) {
    bool isLoading = id.isEmpty;

    return ValueListenableBuilder(
        valueListenable: local(features.docs).listenable(keys: [id]),
        builder: (context, box, wgt) {
          Item doc = Item(
            parent: features.docs,
            id: id,
            data: local(features.docs).get(id, defaultValue: {}),
          );

          return Consumer<SelectionProvider>(builder: (_, selection, __) {
            bool isSelected = selection.isSelected(doc.id);
            bool isGrid = state.views.isGrid();
            bool isRow = state.views.isRow();
            bool isColumn = state.views.isColumn();
            double width = isRow ? 500 : (isSmallPC() ? (isColumn ? 250 : 220) : 46.4.w);
            double? height = (isGrid || isRow) && !(doc.isHabit() && isRow) ? 300 : null;

            return isLoading
                ? Planet(
                    padding: noPadding,
                    color: styler.appColor(isLight() ? 0.6 : 0.1),
                    width: width,
                    height: height,
                    minHeight: 220,
                  )
                : Planet(
                    onPressed: () => onTapNote(doc),
                    onLongPress: isSelected ? null : () => onLongPressNote(doc),
                    onEnter: (_) => state.focus.set(doc.id),
                    onExit: (_) => state.focus.reset(),
                    width: width,
                    height: height,
                    minHeight: 220,
                    padding: noPadding,
                    color: styler.getItemColor(),
                    radius: borderRadiusTinySmall,
                    borderRadius: BorderRadius.circular(borderRadiusTinySmall),
                    hoverColor: styler.appColor(isImage() ? 0.5 : (styler.isDark ? 0.2 : 0.5)),
                    mouseCursor: SystemMouseCursors.basic,
                    showBorder: true,
                    borderColor: isSelected ? styler.accent() : null,
                    borderWidth: isSelected ? 1.2 : (isDark() ? 0.2 : null),
                    child: IgnorePointer(
                      ignoring: selection.isSelection,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //
                          // if (doc.showCover()) ItemCover(item: doc),
                          DocTitle(doc: doc),
                          //
                          Flexible(
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              padding: doc.isKanban() ? noPadding : padM('lr'),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ItemDetails(item: doc),
                                  if (doc.isKanban()) KanbanOverview(doc: doc),
                                  if (doc.isFinance()) FinanceOverview(item: doc),
                                  if (doc.isBooking()) BookingOverview(item: doc),
                                  if (doc.isHabit()) HabitOverview(doc: doc),
                                  if (doc.isLink()) LinksOverview(item: doc),
                                  if (doc.showEditorOverview()) Flexible(child: ItemEditorOverview(item: doc)),
                                ],
                              ),
                            ),
                          ).animate().fadeIn(),
                          //
                        ],
                      ),
                    ),
                  );
          });
        });
  }
}
