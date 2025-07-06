import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../_theme/breakpoints.dart';
import '../../_theme/spacing.dart';
import '../../_widgets/others/list.dart';
import '../calendar/due_today/due_today.dart';
import '../habits/quickhabits/quick_habits.dart';
import '../tasks/task_lists.dart';

class TimelineView extends StatelessWidget {
  const TimelineView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScroll(
      crossAxisAlignment: CrossAxisAlignment.start,
      padding: isSmallPC() ? padC('l24,r24,t12') : padC('l8,r8,t8'),
      children: [
        //
        DueToday().animate().fadeIn(),
        //
        QuickHabits().animate().fadeIn(),
        //
        TaskLists().animate().fadeIn(),
        //
        elph(),
        //
      ],
    );
  }
}

// slideY(begin: 1, end: 0)
