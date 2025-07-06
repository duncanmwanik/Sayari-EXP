import 'package:flutter/material.dart';

import '../../_helpers/common/global.dart';
import '../../_models/item.dart';
import '../../_state/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_variables/features.dart';
import '../../_widgets/_widgets.dart';
import 'task_entry.dart';

class NewTaskItem extends StatefulWidget {
  const NewTaskItem({
    super.key,
    required this.taskList,
  });

  final Item taskList;

  @override
  State<NewTaskItem> createState() => _NewTaskItemState();
}

class _NewTaskItemState extends State<NewTaskItem> {
  bool isNew = false;

  @override
  Widget build(BuildContext context) {
    Item newTaskEntry = Item(
        isNew: true,
        type: features.todo,
        parent: features.todo,
        id: widget.taskList.id,
        sid: '$itemSubItem${getUniqueId()}',
        data: {itemTimestamp: getUniqueId()});

    if (isNew) {
      return TaskListEntry(
        taskEntry: newTaskEntry,
        onExit: () => setState(() => isNew = false),
      );
    } else {
      return Planet(
        onPressed: () {
          state.input.set(newTaskEntry);
          setState(() => isNew = true);
        },
        slp: true,
        noStyling: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(addIcon, size: normal, extraFaded: true),
            tpw(),
            Flexible(child: AppText('Add Task', size: small, faded: true)),
          ],
        ),
      );
    }
  }
}
