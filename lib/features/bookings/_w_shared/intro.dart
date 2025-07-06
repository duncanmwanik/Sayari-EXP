import 'package:flutter/material.dart';

import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/editor/editor.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class BookingIntro extends StatelessWidget {
  const BookingIntro({super.key});

  @override
  Widget build(BuildContext context) {
    state.editor.reset(blocks: state.share.item.content());

    return Planet(
      noStyling: true,
      padding: padL(),
      maxWidth: 500,
      color: styler.appColor(0.3),
      radius: borderRadiusMedium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Row(
            children: [
              AppIcon(Icons.calendar_month, size: 30, faded: true),
              mpw(),
              Expanded(
                child: AppText(state.share.item.title(), size: title, weight: FontWeight.bold),
              ),
            ],
          ),
          sph(),
          if (!state.editor.isEmpty)
            AppEditor(
              placeholder: 'Book a session...',
              fontSize: medium,
            ),
          //
        ],
      ),
    );
  }
}
