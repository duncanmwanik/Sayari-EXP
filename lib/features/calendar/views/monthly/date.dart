import 'package:flutter/material.dart';

import '../../../../_models/date.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/others/other.dart';
import '../../_helpers/prepare.dart';
import 'label.dart';
import 'sessions.dart';

class MonthDate extends StatelessWidget {
  const MonthDate(this.date, this.width, this.height, {super.key});

  final DateItem date;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Planet(
      enabled: !date.isBad,
      onPressed: () => createSession(date: date, hour: TimeOfDay.now().hour),
      onLongPress: () => createSession(date: date, hour: TimeOfDay.now().hour),
      padding: noPadding,
      radius: 0,
      noStyling: true,
      hoverColor: transparent,
      mouseCursor: SystemMouseCursors.basic,
      child: SizedBox(
        width: (width / 7) - 1,
        height: (height / 6) - 1,
        child: date.isBad
            ? NoWidget()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // label
                  MonthDateLabel(date: date),
                  // sessions for date
                  Expanded(
                    child: MonthDateSessions(date: date),
                  ),
                ],
              ),
      ),
    );
  }
}
