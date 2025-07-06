import 'package:flutter/material.dart';

import '../../../_helpers/date_time/jump_to_date.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/datepicker/sfcalendar.dart';
import '../../../_widgets/others/scroll.dart';
import '../../chat/_helpers/jump_to_date.dart';
import '../../notes/layout/alternate.dart';
import '../../tags/manager.dart';
import '../navbars/vertical.dart';
import 'actions.dart';
import 'header.dart';

class PanelItems extends StatelessWidget {
  const PanelItems({super.key, this.isDrawer = false});

  final bool isDrawer;

  @override
  Widget build(BuildContext context) {
    bool showCalendar = state.views.isCalendar() || state.views.isChat() || state.views.isPlay();
    bool showDocPicker = state.views.isDocs() && state.views.isAlternateView();
    bool showTagManager = !showDocPicker && state.views.isDocs();

    return NoScrollBars(
      child: SingleChildScrollView(
        padding: padMS('lrt'),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            PanelHeader(),
            //
            VeticalNavigation(),
            //
            PanelActions(),
            //
            if (showCalendar)
              SfCalendar(
                isOverview: true,
                margin: padM('t'),
                onSelect: (date) {
                  if (state.views.isCalendar()) jumpToDate(date);
                  if (state.views.isChat()) jumpToChatDate(date);
                },
              ),
            if (showTagManager) TagManager(),
            if (showDocPicker) AlternateView(),
            //
          ],
        ),
      ),
    );
  }
}
