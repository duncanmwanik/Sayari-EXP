import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../_helpers/nav/navigation.dart';
import '../../_services/hive/boxes.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../others/loader.dart';
import '../others/text.dart';
import 'planet.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.label,
    this.onPressed,
    this.isCancel = false,
    this.enabled = true,
    this.minWidth,
  });

  final String? label;
  final Function()? onPressed;
  final bool isCancel;
  final bool enabled;
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: globalBox.listenable(keys: [appBusy]),
      builder: (context, box, child) {
        bool isBusy = box.get(appBusy, defaultValue: false);

        return Planet(
          enabled: !isBusy,
          onPressed: enabled ? onPressed ?? () => popWhatsOnTop() : null,
          minWidth: minWidth ?? 80,
          noStyling: isCancel,
          showBorder: true,
          borderWidth: 0.5,
          margin: isCancel ? null : padS('l'),
          child: Center(
            child: isBusy && !isCancel
                ? AppLoader(color: white, size: normal)
                : AppText(label ?? (isCancel ? 'Cancel' : 'Done'), size: small, extraFaded: !enabled),
          ),
        );
      },
    );
  }
}
