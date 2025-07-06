import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_helpers/extentions/strings.dart';
import '../../_state/views.dart';
import '../../_theme/variables.dart';
import '../calendar/views/view.dart';
import '../chat/view.dart';
import '../notes/tab.dart';
import '../notes/view.dart';
import '../timeline/play.dart';
import '../timeline/view.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsProvider>(
      builder: (context, views, child) {
        return Title(
          title: views.view.cap(),
          color: styler.accent(),
          child: SizedBox(
            width: double.infinity,
            child: views.isTimeline()
                ? TimelineView()
                : views.isCalendar()
                    ? CalendarView()
                    : views.isDocs() && !views.isAlternateView()
                        ? DocView()
                        : views.isDocs() && views.isAlternateView()
                            ? DocTab()
                            : views.isChat()
                                ? ChatView()
                                : views.isPlay()
                                    ? PlayView()
                                    : CalendarView(),
          ),
        );
      },
    );
  }
}
