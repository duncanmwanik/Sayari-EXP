import 'package:flutter/material.dart';

import '../../_helpers/common/helpers.dart';
import '../../_models/item.dart';
import '../../_state/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/_widgets.dart';
import '../bookings/_w_item/booking.dart';
import '../finance/finance.dart';
import '../habits/habit.dart';
import '../kanban/kanban.dart';
import '../links/doc/link.dart';
import '../share/w_settings/shared.dart';
import '_helpers/ontap.dart';
import 'w/cover.dart';
import 'w/details.dart';
import 'w/footer.dart';
import 'w/header.dart';
import 'w/title.dart';

Future<void> showDocBottomSheet(Item item) async {
  await showAppBottomSheet(
    title: item.title(),
    constrainContent: !item.isKanban(),
    footerPadding: noPadding,
    contentPadding: noPadding,
    //
    content: Stack(
      children: [
        // content
        Align(
          alignment: Alignment.topCenter,
          child: NoScrollBars(
            child: SingleChildScrollView(
              padding: padS(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  DocHeader(item: item),
                  //
                  DocCover(),
                  //
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: padC('l32,r32,t16,b56'),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: webSuperMaxWidth),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //
                            NoteTitle(item: item),
                            ItemDetails(item: state.input.item),
                            if (item.isNote()) ShareSettings(),
                            if (item.showEditor()) AppEditor(margin: padL('t')),
                            if (item.isFinance()) Finance(),
                            if (item.isKanban()) Kanban(),
                            if (item.isHabit()) Habit(),
                            if (item.isBooking()) Booking(),
                            if (item.isLink()) Links(),
                            if (!item.isKanban()) spph(),
                            //
                          ],
                        ),
                      ),
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
        ),
        // actions
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: padS(),
            child: AppCloseButton(faded: true),
          ),
        ),
        // footer
        Align(
          alignment: Alignment.bottomCenter,
          child: NoteFooter(),
        ),
        //
      ],
    ),
    //
    whenComplete: isShare() ? null : () => whenCompleteNote(),
    //
  );
}
