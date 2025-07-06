import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/forms/input.dart';
import '../../../_widgets/others/icons.dart';

class SpaceFeatures extends StatelessWidget {
  const SpaceFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Padding(
            padding: padC('t12'),
            child: AppIcon(Icons.subject_rounded, faded: true, size: 18),
          ),
          //
          spw(),
          //
          Expanded(
            child: DataInput(
              inputKey: itemContent,
              hintText: 'Add SpaceFeatures',
              color: transparent,
              hoverColor: transparent,
            ),
          ),
          //
        ],
      );
    });
  }
}
