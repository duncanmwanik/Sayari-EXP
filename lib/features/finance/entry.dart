import 'package:flutter/material.dart';

import '../../_helpers/extentions/strings.dart';
import '../../_models/item.dart';
import '../../_state/_providers.dart';
import '../../_theme/helpers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/menu/confirmation.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '_helpers/helpers.dart';
import 'add_entry.dart';

class Entry extends StatelessWidget {
  const Entry({super.key, required this.entry});

  final Item entry;

  @override
  Widget build(BuildContext context) {
    String type = entry.id.substring(1, 2);
    String amount = formatThousands(entry.amount());
    String date = entry.id.substring(2).stampToTime();

    return Planet(
      onPressed: () => showFinanceEntryDialog(entry),
      padding: padS(),
      noStyling: isLight(),
      showBorder: isLight(),
      borderWidth: 0.5,
      hoverColor: styler.appColor(0.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Planet(
            isSquare: true,
            color: styler.appColor(0.6),
            margin: padM('r'),
            child: AppIcon(Icons.bluetooth, color: type.financeColor(), padding: padS(), size: large),
          ),
          //
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Row(
                  children: [
                    // amount
                    AppText(amount, size: mediumNormal, weight: ft6),
                    spw(),

                    //
                  ],
                ),
                //
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // type title
                    Flexible(child: AppText(entry.typee(), size: small, faded: true)),
                    AppIcon(Icons.keyboard_arrow_right, size: small, extraFaded: true, padding: padS('lr')),
                    // date
                    Flexible(child: AppText(date, size: small, faded: true, padding: padS('l'))),
                    AppIcon(Icons.keyboard_arrow_right, size: small, extraFaded: true, padding: padS('lr')),
                    // description
                    if (entry.content().isNotEmpty)
                      Flexible(child: AppText(entry.content(), size: tinySmall, faded: true, padding: padS('l'))),
                    //
                  ],
                ),
                //
              ],
            ),
          ),
          // delete entry
          Planet(
            menu: confirmationMenu(
              title: 'Remove entry <b>$amount</b>?',
              yeslabel: 'Remove',
              onAccept: () => state.input.remove(entry.id),
            ),
            noStyling: true,
            isSquare: true,
            child: AppIcon(closeIcon, faded: true, size: 12),
          ),
          //
        ],
      ),
    );
  }
}
