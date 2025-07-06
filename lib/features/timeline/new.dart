import 'package:flutter/material.dart';

import '../../../_theme/variables.dart';
import '../../../_widgets/_widgets.dart';
import '../../_theme/spacing.dart';
import '../../_variables/features.dart';
import '../../_widgets/menu/model.dart';
import '../calendar/_helpers/prepare.dart';
import '../notes/_helpers/prepare.dart';
import '../tasks/new_task_list.dart';

class NewTimelineOptions extends StatelessWidget {
  const NewTimelineOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Planet(
      menu: Menu(
        items: [
          //
          MenuItem(label: 'New', labelSize: small, sh: true, popTrailing: true, faded: true),
          //
          MenuItem(
            label: 'Session',
            leading: features.calendar.icon(),
            leadingSize: medium,
            onTap: () => createSession(),
          ),
          //
          MenuItem(
            label: 'Habit',
            leading: features.habits.icon(),
            leadingSize: medium,
            onTap: () => createDoc(features.habits),
          ),
          //
          MenuItem(
            label: 'To-Do List',
            leading: features.todo.icon(),
            leadingSize: medium,
            onTap: () => showCreateTaskListDialog(),
          ),
          //
        ],
      ),
      noStyling: true,
      showBorder: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcon(addIcon, faded: true, size: normal),
          tspw(),
          AppText('New', size: small, faded: true),
        ],
      ),
    );
  }
}
