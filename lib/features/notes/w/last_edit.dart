import 'package:flutter/material.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/others/other.dart';
import '../../../_widgets/others/text.dart';

class LastEdit extends StatelessWidget {
  const LastEdit({super.key, this.timestamp});

  final String? timestamp;

  @override
  Widget build(BuildContext context) {
    return timestamp != null
        ? Padding(
            padding: padS(),
            child: AppText(
              size: tiny,
              'Edited ${timestamp?.stampToTime(false)}',
              faded: true,
              padding: isSmallPC() ? padM('r') : null,
            ),
          )
        : NoWidget();
  }
}
