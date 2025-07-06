import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../_models/item.dart';
import '../../_services/hive/boxes.dart';
import '../../_services/hive/store.dart';
import '../../_theme/helpers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/planet.dart';
import 'header.dart';
import 'task_list_content.dart';

class QuickTask extends StatelessWidget {
  const QuickTask({
    super.key,
    required this.taskListId,
  });

  final String taskListId;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: local(features.todo).listenable(keys: [taskListId]),
      builder: (context, box, child) {
        Item taskList = Item(
          type: features.todo,
          parent: features.todo,
          id: taskListId,
          data: box.get(taskListId, defaultValue: {}),
        );

        return Planet(
          padding: noPadding,
          showBorder: isLight(),
          noStyling: isLight(),
          color: styler.appColor(0.6),
          radius: borderRadiusSmall,
          child: Theme(
            data: expansionTileThemeData,
            child: ExpansionTile(
              dense: true,
              clipBehavior: Clip.none,
              initiallyExpanded: globalBox.get(taskListId, defaultValue: true),
              onExpansionChanged: (value) => globalBox.put(taskListId, value),
              // initiallyExpanded: taskList.isExpanded(true),
              // onExpansionChanged: (value) =>
              //     quickEdit(action: 'c', parent: features.todo, id: taskList.id, key: itemExpand, value: value ? 0 : 1),
              tilePadding: padC('l6,r12'),
              childrenPadding: padM('lrb'),
              expandedAlignment: Alignment.topLeft,
              collapsedShape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusSmall)),
              shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusSmall)),
              iconColor: styler.textColor(extraFaded: true),
              collapsedIconColor: styler.textColor(extraFaded: true),
              title: QuickTaskHeader(taskList: taskList),
              children: [
                //
                QuickTaskContent(taskList: taskList),
                //
              ],
            ),
          ),
        );
      },
    );
  }
}
