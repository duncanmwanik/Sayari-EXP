import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/navigation.dart';
import '../buttons/planet.dart';
import 'icons.dart';
import 'text.dart';

void toastSuccess(String message, {String? description, int? duration}) {
  showToast(message, description: description, icon: Icons.check_circle, color: Colors.green, duration: duration);
}

void toastError(String message, {String? description, int? duration}) {
  showToast(message, description: description, icon: Icons.info, color: Colors.red, duration: duration);
}

void toastInfo(String message, {String? description, int? duration}) {
  showToast(message, description: description, icon: Icons.info, color: Colors.blue, duration: duration);
}

void showToast(String message, {String? description, IconData? icon, Color? color, int? duration}) {
  toastification.showCustom(
    context: navigatorState.currentState!.context,
    autoCloseDuration: Duration(seconds: duration ?? 5),
    builder: (context, holder) {
      return Planet(
        maxWidth: 380,
        padding: padS(),
        margin: padM('b'),
        color: styler.tertiaryColor(),
        borderRadius: BorderRadius.circular(borderRadiusTinySmall),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // type icon
            AppIcon(
              icon ?? Icons.info,
              color: color ?? Colors.blue,
              padding: padS(),
            ),
            // text
            Expanded(
              child: Padding(
                padding: padC('t4,l8,r8'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(message),
                    if (description != null) AppText(description, size: mediumSmall, faded: true, padding: padT('tb')),
                  ],
                ),
              ),
            ),
            // close btn
            Planet(
              onPressed: () => toastification.dismissById(holder.id),
              noStyling: true,
              padding: padS(),
              child: AppIcon(Icons.close, size: 18, extraFaded: true),
            ),
            //
          ],
        ),
      );
    },
  );
}
