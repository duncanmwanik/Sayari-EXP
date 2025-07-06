import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../_helpers/extentions/date_time.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/others/text.dart';

class Hour extends StatelessWidget {
  const Hour({
    super.key,
    required this.indexHour,
    required this.isCurrentHour,
    this.showTopBorder = true,
  });

  final int indexHour;
  final bool isCurrentHour;
  final bool showTopBorder;

  @override
  Widget build(BuildContext context) {
    return Planet(
      width: 45,
      padding: padC('r10,t12'),
      noStyling: true,
      radius: 0,
      child: AppText(
        size: 10,
        DateTime(1999, 0, 0, indexHour).hourText(),
        faded: true,
        color: isCurrentHour ? styler.accent() : null,
        textAlign: TextAlign.end,
      ),
    ).animate().slideX();
  }
}
