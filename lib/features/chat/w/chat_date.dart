import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/date_time/jump_to_date.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_models/date.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/jump_to_date.dart';
import '../state/chat.dart';

class ChatDate extends StatelessWidget {
  const ChatDate({super.key, required this.date});

  final DateItem date;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chat, child) {
      return Planet(
        onPressed: !isPhone()
            ? null
            : () => showDateDialog(onSelect: (date) {
                  jumpToChatDate(date);
                  popWhatsOnTop();
                }),
        menu: isPhone() ? null : jumpToDateMenu((date) => popWhatsOnTop(todo: () => jumpToChatDate(date))),
        margin: padL('tb'),
        color: styler.appColor(0.4),
        radius: borderRadiusLarge,
        child: AppText(
          date.isToday()
              ? 'Today'
              : date.isYesterday()
                  ? 'Yesterday'
                  : date.dateInfo(),
          size: tiny,
        ),
      );
    });
  }
}
