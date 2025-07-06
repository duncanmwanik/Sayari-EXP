import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/others/text.dart';
import 'quick_habit.dart';

class QuickHabitsBuilder extends StatelessWidget {
  const QuickHabitsBuilder({
    super.key,
    this.ids = const [],
    this.isLoading = false,
  });
  final List ids;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (ids.isNotEmpty) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return MasonryGridView(
            shrinkWrap: true,
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: constraints.maxWidth > webMaxWidth ? 3 : 2,
            ),
            mainAxisSpacing: msw(),
            crossAxisSpacing: msw(),
            children: [
              //
              for (String id in ids) QuickHabitItem(id: id, isLoading: isLoading),
              //
            ],
          );
        },
      );
    } else {
      return AppText('No habits created...', extraFaded: true, padding: padM('l'));
    }
  }
}
