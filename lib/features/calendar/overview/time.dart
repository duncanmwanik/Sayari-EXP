import 'package:flutter/material.dart';

import '../../../_models/date.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/others/text.dart';

class SessionTime extends StatelessWidget {
  const SessionTime({
    super.key,
    required this.label,
    required this.date,
  });

  final String label;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 60, child: AppText(label, size: mediumSmall, faded: true)),
        tpw(),
        Flexible(
          child: AppText(DateItem(date).info(), weight: FontWeight.w500),
        ),
      ],
    );
  }
}
