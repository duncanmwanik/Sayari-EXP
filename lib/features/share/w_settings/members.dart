import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/menu/confirmation.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/share.dart';

class ShareItemMembers extends StatelessWidget {
  const ShareItemMembers({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          if (input.item.isSharedRestricted())
            Wrap(
              spacing: sw(),
              runSpacing: sw(),
              children: [
                //
                for (String email in input.item.shareItemMembers())
                  Planet(
                    padding: padC('l6'),
                    svp: true,
                    showBorder: true,
                    noStyling: true,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(child: AppText(email)),
                        spw(),
                        Planet(
                          menu: confirmationMenu(
                            title: 'Remove <b>$email</b>?',
                            yeslabel: 'Remove',
                            onAccept: () => removeSharedMember(email),
                          ),
                          noStyling: true,
                          isSquare: true,
                          child: AppIcon(Icons.close, size: normal, faded: true),
                        ),
                      ],
                    ),
                  ),
                //
              ],
            )
        ],
      );
    });
  }
}
