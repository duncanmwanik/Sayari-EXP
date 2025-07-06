import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_state/views.dart';
import '../../_theme/breakpoints.dart';
import '../../_theme/variables.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/icons.dart';
import '../calendar/_helpers/prepare.dart';
import '../notes/_helpers/prepare.dart';
import '../notes/state/selection.dart';

class HomeFab extends StatelessWidget {
  const HomeFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ViewsProvider, SelectionProvider>(builder: (context, views, selection, child) {
      return Visibility(
        visible: !isSmallPC() && !selection.isSelection && !views.isChat() && !views.isTimeline(),
        child: FloatingActionButton(
          onPressed: () {
            if (views.isCalendar()) createSession();
            if (views.isDocs()) createDoc(features.notes);
          },
          mini: true,
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          disabledElevation: 0,
          backgroundColor: styler.accent(),
          child: AppIcon(Icons.add),
        ),
      );
    });
  }
}
