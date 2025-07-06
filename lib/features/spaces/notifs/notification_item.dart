import 'package:flutter/material.dart';

import '../../../_services/hive/store.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/checkbox.dart';
import '../../../_widgets/others/text.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    bool show = local(notifications).get(type, defaultValue: false);
    Future<void> onTap() => local(notifications).put(type, !show);

    return Planet(
      onPressed: () => onTap,
      slp: true,
      margin: padS('b'),
      color: styler.appColor(0.5),
      child: Row(
        children: [
          AppCheckBox(isChecked: show, onTap: () => onTap),
          spw(),
          Flexible(child: AppText(type.title())),
        ],
      ),
    );
  }
}
