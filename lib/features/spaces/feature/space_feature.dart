import 'package:flutter/material.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/checkbox.dart';
import '../../../_widgets/others/text.dart';

class SpaceFeature extends StatelessWidget {
  const SpaceFeature({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;

    return Planet(
      onPressed: () {},
      gradient: styler.gradient(colors: [type.toColor(), styler.appColor(10)]),
      hoverColor: styler.appColor(0.5),
      radius: borderRadiusSmall,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Expanded(
            child: AppText(
              type,
              size: normal,
              weight: ft6,
              padding: padC('l2,r20,t2'),
            ),
          ),
          // checkbox
          Planet(
            height: 35,
            width: 35,
            padding: noPadding,
            isSquare: true,
            noStyling: true,
            // onPressed: () => quickEdit(
            //   action: isChecked ? 'd' : 'c',
            //   parent: item.parent,
            //   id: item.id,
            //   key: isChecked ? dateKey : dateKey,
            //   value: getUniqueId(),
            // ),
            child: AppCheckBox(
              size: 25,
              isChecked: isChecked,
              showCheck: true,
              onTap: null,
            ),
          ),
          //
        ],
      ),
    );
  }
}
