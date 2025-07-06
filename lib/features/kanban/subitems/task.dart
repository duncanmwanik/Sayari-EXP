import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/checkbox.dart';
import '../../../_widgets/others/text.dart';
import '../../reminders/reminder.dart';
import 'edit_dialog.dart';
import 'flags.dart';

class KanbanListItem extends StatefulWidget {
  const KanbanListItem({
    super.key,
    required this.task,
    required this.showChecks,
  });

  final Item task;
  final bool showChecks;

  @override
  State<KanbanListItem> createState() => _ItemState();
}

class _ItemState extends State<KanbanListItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: Planet(
        onPressed: () => showItemDialog(widget.task),
        onHover: (value) => setState(() => isHovered = value),
        hoverColor: transparent,
        color: styler.appColor(0.3),
        padding: padC('l4,r4,t4,b4'),
        showBorder: true,
        borderColor: (isHovered) ? styler.accent() : styler.appColor(1),
        child: Align(
          alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    ItemFlagList(flagList: widget.task.flags(), isTinyFlag: true),
                    if (widget.task.hasFlags()) sph(),
                    //
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // checkbox
                        if (widget.showChecks)
                          AppCheckBox(
                            isChecked: widget.task.isChecked(),
                            margin: padC('r6,t0.7'),
                            onTap: () {
                              Map newTaskData = {...widget.task.data};
                              newTaskData[itemChecked] = widget.task.isChecked() ? 0 : 1;
                              state.input.update(parentKey: widget.task.id, widget.task.sid, newTaskData);
                            },
                          ),
                        // text
                        Expanded(
                          child: AppText(
                            widget.task.title(),
                            padding: widget.showChecks ? padC('t4') : padC('l3,r3'),
                          ),
                        ),
                      ],
                    ),
                    //
                    if (widget.task.hasReminder() || widget.task.hasFiles())
                      Wrap(
                        spacing: tw(),
                        runSpacing: tw(),
                        children: [
                          // reminder
                          if (widget.task.hasReminder()) Reminder(item: widget.task),
                          // files
                          // if (widget.task.hasFiles()) FileListOverview(item: widget.list, sitem: widget.task),
                        ],
                      ),
                  ],
                ),
              ),
              //
              spw(),
              //
            ],
          ),
        ),
      ),
    );
  }
}
