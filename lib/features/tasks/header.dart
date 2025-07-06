import 'package:flutter/material.dart';

import '../../_models/item.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/features.dart';
import '../../_widgets/_widgets.dart';
import 'task_list_menu.dart';

class QuickTaskHeader extends StatelessWidget {
  const QuickTaskHeader({
    super.key,
    required this.taskList,
  });

  final Item taskList;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        Planet(
          slp: true,
          noStyling: true,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(
                features.todo.icon(),
                size: normal,
                extraFaded: true,
                color: styler.getBgColor(taskList.color()),
              ),
              spw(),
              AppText(
                taskList.title(),
                bold: true,
                faded: true,
                color: styler.getBgColor(taskList.color()),
              ),
            ],
          ),
        ),
        Spacer(),
        //
        Planet(
          menu: taskListMenu(taskList),
          isSquare: true,
          padding: padS(),
          noStyling: true,
          faded: true,
          child: AppIcon(moreIcon, extraFaded: true),
        ),
        //
      ],
    );
  }
}
