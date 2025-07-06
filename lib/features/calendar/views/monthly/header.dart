import 'package:flutter/material.dart';

import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/others/text.dart';
import '../../_var/date_time.dart';

class MonthHeader extends StatelessWidget {
  const MonthHeader({super.key, this.isInitials = false});

  final bool isInitials;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        7,
        (index) => Flexible(
          child: Planet(
            noStyling: true,
            padding: padC('t1,b1'),
            child: AppText(
              size: isInitials ? tiny : small,
              isInitials ? weekDaysList[index].superShortName : weekDaysList[index].shortName,
              faded: true,
            ),
          ),
        ),
      ),
    );
  }
}
