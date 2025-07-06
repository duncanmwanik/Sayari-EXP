import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_models/item.dart';
import '../../../_state/focus.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import 'actions_menu.dart';

class MessageActions extends StatelessWidget {
  const MessageActions({super.key, required this.message, this.isSent = false});

  final Item message;
  final bool isSent;

  @override
  Widget build(BuildContext context) {
    return Consumer<FocusProvider>(
      builder: (context, focus, child) => Visibility(
        visible: focus.id == message.sid,
        child: Padding(
          padding: padT('t'),
          child: Planet(
            menu: chatMenu(message),
            isRound: true,
            noStyling: true,
            child: AppIcon(Icons.more_horiz, size: normal, faded: true),
          ),
        ),
      ),
    );
  }
}
