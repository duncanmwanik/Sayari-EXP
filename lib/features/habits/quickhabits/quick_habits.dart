import 'package:flutter/material.dart';

import '../../../_variables/features.dart';
import '../../../_widgets/others/future.dart';
import '../../notes/_helpers/chosen.dart';
import '../../timeline/tile.dart';
import 'builder.dart';

class QuickHabits extends StatelessWidget {
  const QuickHabits({super.key});

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      title: 'Habits',
      children: [
        //
        AppFuture(
          future: getChosenItems([features.habits]),
          errorWidget: QuickHabitsBuilder(isLoading: true),
          loadingWidget: QuickHabitsBuilder(isLoading: true),
          widget: (data) => QuickHabitsBuilder(ids: data),
        ),
        //
      ],
    );
  }
}
