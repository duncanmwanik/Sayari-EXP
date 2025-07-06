import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/forms/input.dart';
import '../../../_widgets/others/icons.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(
        builder: (context, input, child) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // icon
                AppIcon(
                  Icons.subject_rounded,
                  faded: true,
                  size: extra,
                  padding: padC('t12,r8'),
                ),
                // input
                Expanded(
                  child: DataInput(
                    inputKey: itemAbout,
                    hintText: 'Short Description',
                    textCapitalization: TextCapitalization.sentences,
                    color: transparent,
                  ),
                ),
                //
              ],
            ));
  }
}
