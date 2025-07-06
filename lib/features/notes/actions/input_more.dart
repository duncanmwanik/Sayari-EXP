import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/nav/navigation.dart';
import '../../../_state/input.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/files/_helpers/get_files.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/menu/model.dart';
import '../../../_widgets/others/icons.dart';
import '../../habits/habit_options.dart';
import '../../kanban/options.dart';
import '../../reminders/edit_menu.dart';
import '../../share/_helpers/share.dart';
import '../../tts/_helpers/tts_service.dart';
import '../../tts/_state/tts_provider.dart';
import '../_helpers/misc.dart';

class MoreInputActions extends StatelessWidget {
  const MoreInputActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool isArchived = input.item.isArchived();

      return Planet(
        tooltip: 'More',
        menu: Menu(
          items: [
            //
            if (!input.item.hasReminder())
              MenuItem(
                menu: reminderMenu(input.item),
                label: 'Add Reminder',
                leading: reminderIcon,
              ),
            //
            MenuItem(
              onTap: () async => await getFilesToUpload(),
              label: 'Attach Files',
              leading: fileIcon,
              leadingSize: medium,
            ),
            //
            if (input.item.isKanban()) TaskOptions(),
            //
            if (input.item.isHabit()) HabitOptions(),
            //
            if (input.item.isNote())
              Consumer<TTSProvider>(
                builder: (context, tts, child) => MenuItem(
                  label: tts.isPlaying ? 'Stop Narration' : 'Narrate',
                  leading: tts.isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
                  onTap: () {
                    tts.updateTextToSpeak(getEditorText());
                    tts.isPlaying ? ttsService.stopTTS() : ttsService.startTTS();
                  },
                ),
              ),
            //
            if (!input.item.isShared() && input.item.isNote())
              MenuItem(
                label: 'Share',
                leading: shareIcon,
                onTap: () => shareItem(),
              ),
            //
            menuDivider(),
            //
            if (!input.item.isNew)
              MenuItem(
                label: isArchived ? 'Unarchive' : 'Archive',
                leading: isArchived ? unarchiveIcon : archiveIcon,
                onTap: () {
                  isArchived ? input.remove(itemArchived) : input.update(itemArchived, 1);
                  if (!isArchived) closeBottomSheet();
                },
              ),
            //
            if (!input.item.isNew)
              MenuItem(
                label: 'Move To Trash',
                leading: deleteIcon,
                onTap: () async {
                  input.update(itemTrashed, 1);
                  if (!isArchived) closeBottomSheet();
                },
              ),
            //
          ],
        ),
        isSquare: true,
        noStyling: true,
        child: AppIcon(moreIcon, faded: true, size: normal),
      );
    });
  }
}
