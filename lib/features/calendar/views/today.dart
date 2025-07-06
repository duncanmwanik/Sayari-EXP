import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/common/global.dart';
import '../../../_helpers/extentions/date_time.dart';
import '../../../_models/date.dart';
import '../../../_state/views.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/helpers.dart';
import '../_state/date.dart';

class Today extends StatelessWidget {
  const Today({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<DateProvider, ViewsProvider>(builder: (context, dates, views, child) {
      return Planet(
        onPressed: dates.date.isToday() ? () {} : () => goToToday(),
        tooltip: DateItem(now().format()).dateInfo(),
        margin: padM('r'),
        showBorder: true,
        noStyling: true,
        svp: true,
        radius: borderRadiusLarge,
        child: AppText('Today'),
      );
    });
  }
}
