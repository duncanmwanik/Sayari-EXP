import 'package:flutter/material.dart';

import '../../../../_models/date.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/others/future.dart';
import '../../../../_widgets/others/icons.dart';
import '../../_helpers/sort.dart';

class MonthShowAllSessions extends StatelessWidget {
  const MonthShowAllSessions({
    super.key,
    required this.date,
  });

  final DateItem date;

  @override
  Widget build(BuildContext context) {
    return AppFuture(
        future: sortSessions(date),
        widget: (sessions) {
          return Visibility(
            visible: sessions.length > 3,
            child: Padding(
              padding: padS('l'),
              child: AppIcon(
                Icons.keyboard_arrow_down,
                size: medium,
              ),
            ),
          );
        });
  }
}
