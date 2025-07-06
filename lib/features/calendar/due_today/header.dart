import 'package:flutter/material.dart';

import '../../../_helpers/common/global.dart';
import '../../../_models/date.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/prepare.dart';

class DueTodayHeader extends StatelessWidget {
  const DueTodayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    DateItem date = DateItem.now();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // desc
        Flexible(
          child: AppText('Today • ${date.dateInfo()}', faded: true),
        ),
        spw(),
        // new
        Planet(
          onPressed: () => createSession(date: date, hour: now().hour),
          isSquare: true,
          noStyling: true,
          faded: true,
          leading: Icons.add,
        )
        //
      ],
    );
  }
}
