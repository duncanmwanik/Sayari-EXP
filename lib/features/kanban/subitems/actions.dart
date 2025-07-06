import 'package:flutter/material.dart';

import '../../../_helpers/common/global.dart';
import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/toast.dart';
import '../../flags/flags_menu.dart';
import '../../reminders/edit_menu.dart';
import 'delete_menu.dart';

class SubItemActions extends StatelessWidget {
  const SubItemActions({super.key, required this.task});

  final Item task;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //
        Expanded(
          child: Wrap(
            spacing: sw(),
            runSpacing: sw(),
            children: [
              //
              Planet(
                tooltip: 'Reminder',
                menu: reminderMenu(state.input2.item),
                isSquare: true,
                noStyling: true,
                child: AppIcon(Icons.notification_add_outlined, faded: true, size: 16),
              ),
              //
              Planet(
                tooltip: 'Flags',
                menu: flagsMenu(
                  alreadySelected: state.input2.item.flags(),
                  onDone: (newFlags) => state.input2.update('g', joinList(newFlags)),
                ),
                isSquare: true,
                noStyling: true,
                child: AppIcon(Icons.flag_outlined, faded: true, size: 16),
              ),
              //
              // Planet(
              //   tooltip: 'Attach Files',
              //   onPressed: () async => await getFilesToUpload(),
              //   isSquare: true,
              //   noStyling: true,
              //   child: AppIcon(Icons.attach_file_rounded, faded: true, size: 16),
              // ),
              //
              Planet(
                tooltip: 'Asign To Member',
                onPressed: () {
                  toastInfo('Not available at the moment.');
                },
                isSquare: true,
                noStyling: true,
                child: AppIcon(Icons.person, faded: true, size: 16),
              ),
              //
            ],
          ),
        ),
        //
        spw(),
        DeleteItem(task: task),
        //
      ],
    );
  }
}
