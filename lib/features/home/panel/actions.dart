import 'package:flutter/material.dart';

import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/divider_vertical.dart';
import '../../calendar/_helpers/prepare.dart';
import '../../calendar/new/new.dart';
import '../../chat/w/filters.dart';
import '../../notes/_helpers/prepare.dart';
import '../../notes/layout/button.dart';
import '../../notes/w/new_doc.dart';
import '../../tags/switcher.dart';
import '../../timeline/new.dart';

class PanelActions extends StatelessWidget {
  const PanelActions({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDocs = state.views.isDocs();
    bool isChat = state.views.isChat();
    bool isTimeline = state.views.isTimeline();
    bool isAlternate = state.views.isAlternateView();
    bool isCalendar = state.views.isCalendar();

    return Visibility(
      visible: isDocs || isCalendar || isChat || isTimeline,
      child: Planet(
        enabled: isCalendar,
        onPressed: () {
          if (isDocs) createDoc(state.views.docView);
          if (isCalendar) createSession();
        },
        margin: padM('tb'),
        padding: noPadding,
        noStyling: true,
        borderWidth: 0.3,
        minHeight: 26,
        radius: borderRadiusSmall,
        child: Row(
          children: [
            //
            if (isDocs && isAlternate) TagSwitcher(),
            if (isDocs && isAlternate) AppSeparator(isVertical: true),
            //
            if (isDocs) Expanded(child: NewDoc()),
            if (isChat) Expanded(child: ChatFilters()),
            if (isCalendar) Expanded(child: NewSession()),
            if (isTimeline) Expanded(child: NewTimelineOptions()),
            //
            if (isDocs) AppSeparator(isVertical: true),
            if (isDocs) LayoutButton(),
            //
          ],
        ),
      ),
    );
  }
}
