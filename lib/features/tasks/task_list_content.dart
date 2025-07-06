import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:reorderables/reorderables.dart';

import '../../_models/item.dart';
import '../../_services/hive/store.dart';
import '../../_theme/spacing.dart';
import '../../_variables/constants.dart';
import '../../_variables/features.dart';
import '../notes/_helpers/order.dart';
import 'new_task_entry.dart';
import 'task_entry.dart';

class QuickTaskContent extends StatelessWidget {
  const QuickTaskContent({
    super.key,
    required this.taskList,
  });

  final Item taskList;

  @override
  Widget build(BuildContext context) {
    Map taskEntries = taskList.subItems();
    List taskEntriesIds = taskEntries.keys.toList();
    taskEntriesIds.sort((a, b) => int.parse(taskEntries[a][itemOrder] ?? '0').compareTo(int.parse(taskEntries[b][itemOrder] ?? '0')));
    taskEntriesIds = taskEntriesIds.reversed.toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        NewTaskItem(taskList: taskList),
        sph(),
        //
        if (taskEntriesIds.isNotEmpty)
          Flexible(
            child: ValueListenableBuilder(
                valueListenable: local(features.todo).listenable(),
                builder: (context, box, child) {
                  return ReorderableWrap(
                    maxMainAxisCount: 1,
                    runSpacing: th(),
                    onReorder: (oldIndex, newIndex) => orderSubItem(
                      parent: features.todo,
                      itemId: features.todo,
                      oldItemId: taskEntriesIds[oldIndex - 1],
                      newItemId: taskEntriesIds[newIndex - 1],
                      itemsLength: taskEntriesIds.length,
                      oldIndex: oldIndex,
                      newIndex: newIndex,
                    ),
                    children: List.generate(taskEntriesIds.length, (index) {
                      String id = taskEntriesIds[index];
                      return TaskListEntry(
                        taskEntry: Item(
                          type: features.todo,
                          parent: features.todo,
                          id: taskList.id,
                          sid: id,
                          temp: taskList.color(),
                          data: taskEntries[id],
                        ),
                      );
                    }),
                  );
                }),
          ),
        //
        // if (taskEntriesIds.isEmpty) Padding(padding: padL('lb'), child: AppText('No taskEntries yet...', extraFaded: true)),
        //
      ],
    );
  }
}
