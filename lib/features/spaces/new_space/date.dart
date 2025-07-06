import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/extentions/date_time.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_models/date.dart';
import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class Dates extends StatelessWidget {
  const Dates({super.key, this.showIcon = false});

  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Row(
        children: [
          //
          if (showIcon)
            AppIcon(
              Icons.calendar_month_rounded,
              faded: true,
              size: extra,
              padding: padM('r'),
            ),
          //
          Flexible(
            child: Wrap(
              spacing: sw(),
              runSpacing: sw(),
              children: [
                for (String type in [itemStart, itemEnd])
                  Planet(
                    onPressed: () async => await showDateDialog(
                      initialDate: type == itemStart ? input.item.start() : input.item.end(),
                      onSelect: (selectedDate) {
                        input.update(type, selectedDate.datePart());
                        popWhatsOnTop();
                      },
                    ),
                    svp: true,
                    slp: true,
                    srp: input.item.has(type),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcon(editIcon, size: normal, faded: true, padding: padMS('r')),
                        // date
                        Flexible(
                          child: AppText(
                            DateItem(
                              type == itemStart ? input.item.start() : input.item.end(),
                            ).isBad
                                ? (type == itemStart ? 'Starting' : 'Ending')
                                : '${type == itemStart ? 'Starting' : 'Ending'} on <b>${DateItem(
                                    type == itemStart ? input.item.start() : input.item.end(),
                                  ).dateInfo()}</b>',
                          ),
                        ),
                        //
                        if (input.item.has(type))
                          Planet(
                            onPressed: () => input.remove(type),
                            margin: padM('l'),
                            noStyling: true,
                            isSquare: true,
                            child: AppIcon(closeIcon, faded: true, size: normal),
                          ),
                        //
                      ],
                    ),
                  ),

                //
              ],
            ),
          ),
          //
        ],
      );
    });
  }
}
