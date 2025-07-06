import 'package:flutter/material.dart';

import '../../_models/item.dart';
import '../../_services/cloud/sync/create_item.dart';
import '../../_services/cloud/sync/edit_item.dart';
import '../../_services/cloud/sync/quick_edit.dart';
import '../../_theme/helpers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/forms/input.dart';
import '../../_widgets/others/checkbox.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import 'actions.dart';

class TaskListEntry extends StatefulWidget {
  const TaskListEntry({
    super.key,
    required this.taskEntry,
    this.onExit,
  });

  final Item taskEntry;
  final Function()? onExit;

  @override
  State<TaskListEntry> createState() => _TaskListEntryState();
}

class _TaskListEntryState extends State<TaskListEntry> {
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    bool isNew = widget.taskEntry.isNew;
    bool hasFocus = isNew || isEdit;
    bool isChecked = widget.taskEntry.isChecked();

    return TapRegion(
      enabled: hasFocus,
      onTapOutside: (_) {
        if (isNew) {
          widget.onExit!();
        } else {
          setState(() => isEdit = false);
        }
      },
      child: Planet(
        blurred: isImage(),
        padding: padMS(),
        color: styler.appColor(0.6),
        hoverColor: styler.appColor(0.6),
        onPressed: hasFocus
            ? null
            : () => quickEdit(
                  parent: widget.taskEntry.parent,
                  id: widget.taskEntry.id,
                  sid: widget.taskEntry.sid,
                  key: itemChecked,
                  value: isChecked ? 0 : 1,
                ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // checkbox
            AppCheckBox(
              margin: padC('l3,r6,t2'),
              isChecked: isChecked,
              size: normal,
              color: styler.getBgColor(widget.taskEntry.temp),
              onTap: hasFocus
                  ? null
                  : () => quickEdit(
                        parent: widget.taskEntry.parent,
                        id: widget.taskEntry.id,
                        sid: widget.taskEntry.sid,
                        key: itemChecked,
                        value: isChecked ? 0 : 1,
                      ),
            ),
            // text
            Expanded(
              child: hasFocus
                  ? DataInput(
                      hintText: 'Task',
                      color: transparent,
                      weight: isDark() ? FontWeight.w400 : FontWeight.w500,
                      hoverColor: transparent,
                      clean: true,
                      autofocus: hasFocus,
                      enabled: hasFocus,
                      contentPadding: noPadding,
                      margin: padC('t3.2'),
                      onFieldSubmitted: (_) => () async {
                        if (isNew) {
                          await createItem();
                          widget.onExit!();
                        } else {
                          await editItem();
                          setState(() => isEdit = false);
                        }
                      },
                    )
                  : AppText(widget.taskEntry.title(), padding: padC('t4.8')),
            ),
            // save task
            if (hasFocus)
              Planet(
                onPressed: () async {
                  if (isNew) {
                    await createItem();
                    widget.onExit!();
                  } else {
                    editItem();
                    setState(() => isEdit = false);
                  }
                },
                noStyling: true,
                isSquare: true,
                margin: padS('l'),
                child: AppIcon(Icons.done, size: normal, faded: true),
              ),
            // cancel
            if (hasFocus)
              Planet(
                onPressed: () => isNew ? widget.onExit!() : setState(() => isEdit = false),
                noStyling: true,
                isSquare: true,
                margin: padS('l'),
                child: AppIcon(Icons.close, size: normal, faded: true),
              ),
            // actions
            if (!hasFocus)
              QuickTaskActions(
                taskEntry: widget.taskEntry,
                onEditStart: () => setState(() => isEdit = true),
              ),
            //
          ],
        ),
      ),
    );
  }
}
