import 'package:flutter/material.dart';

import '../../../_models/date.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/others/text.dart';
import '../../timeline/tile.dart';
import '../views/daily/sessions.dart';

class DueToday extends StatelessWidget {
  const DueToday({super.key});

  @override
  Widget build(BuildContext context) {
    DateItem date = DateItem.now();

    return TimelineTile(
      title: 'Today • ${date.dateInfo()}',
      children: [
        //
        DailySessions(
          date: DateItem.now(),
          emptyWidget: AppText('No sessions today...', extraFaded: true, padding: padM('l')),
        ),
        //
      ],
    );
  }
}
