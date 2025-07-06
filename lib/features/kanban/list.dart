import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../_models/item.dart';
import '../../_state/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_widgets/_widgets.dart';
import '../notes/w/emoji.dart';
import 'list_actions.dart';
import 'subitems/new.dart';
import 'subitems/progress.dart';
import 'subitems/tasks.dart';

class KanbanList extends StatelessWidget {
  const KanbanList({super.key, required this.list});

  final Item list;

  @override
  Widget build(BuildContext context) {
    double maxWidth = 270;

    if (list.id.isEmpty) {
      return Planet(
        padding: padS(),
        width: maxWidth,
        minHeight: 300,
        color: styler.getItemColor(),
        showBorder: true,
      );
    } else {
      return IgnorePointer(
        ignoring: !list.isInput,
        child: Planet(
          padding: padMS(),
          maxWidth: maxWidth,
          minHeight: 300,
          color: styler.getItemColor(),
          showBorder: true,
          borderWidth: 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  Emoji(
                    doc: list,
                    onSelect: (emoji) => state.input.update(parentKey: list.id, itemEmoji, emoji),
                    onRemove: () => state.input.remove(parentKey: list.id, itemEmoji),
                  ),
                  //
                  Expanded(
                    child: DataInput(
                      initialValue: list.title(),
                      onChanged: (value) => state.input.update(parentKey: list.id, itemTitle, value, notify: false),
                      contentPadding: padS('rb'),
                      margin: padT('t'),
                      fontSize: medium,
                      color: transparent,
                    ),
                  ),
                  //
                  if (list.isInput) ListActions(list: list)
                  //
                ],
              ),
              sph(),
              //
              if (list.hasTasks() && state.input.item.showChecks()) ProgressBar(item: list),
              //
              Flexible(child: KanbanListItems(list: list)),
              //
              if (list.hasTasks()) tsph(),
              if (list.isInput) NewItemInput(list: list),
              //
            ],
          ).animate().fadeIn(),
        ),
      );
    }
  }
}
