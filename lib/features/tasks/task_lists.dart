import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../_services/hive/store.dart';
import '../../../_theme/spacing.dart';
import '../../../_variables/features.dart';
import '../../_theme/variables.dart';
import '../../_widgets/others/text.dart';
import '../../_widgets/rebuilders/length.dart';
import '../timeline/tile.dart';
import 'task_list.dart';

class TaskLists extends StatelessWidget {
  const TaskLists({super.key});

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      title: 'To-Do',
      children: [
        //
        LengthRebuilder(
          feature: features.todo,
          child: () {
            if (local(features.todo).isNotEmpty) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return MasonryGridView(
                    shrinkWrap: true,
                    gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth > webMaxWidth ? 2 : 1,
                    ),
                    mainAxisSpacing: msw(),
                    crossAxisSpacing: msw(),
                    children: [
                      for (String taskListId in local(features.todo).keys) QuickTask(taskListId: taskListId),
                    ],
                  );
                },
              );
            } else {
              return AppText('No to-do lists created...', extraFaded: true, padding: padM('l'));
            }
          },
        ),
        //
      ],
    );
  }
}
