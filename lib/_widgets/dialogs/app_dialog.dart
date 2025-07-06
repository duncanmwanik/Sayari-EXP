import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../_helpers/nav/navigation.dart';
import '../../_theme/breakpoints.dart';
import '../../_theme/helpers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/navigation.dart';
import '../_widgets.dart';

Future<dynamic> showAppDialog({
  dynamic title,
  Widget? content,
  List<Widget>? actions,
  EdgeInsets? titlePadding,
  EdgeInsets? contentPadding,
  bool showTitleColor = false,
  bool showClose = true,
  double? maxWidth,
}) {
  hideKeyboard();

  return showGeneralDialog<dynamic>(
    context: navigatorState.currentContext!,
    transitionDuration: const Duration(milliseconds: 300),
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black.withOpacity(styler.isDark ? 0.5 : 0.2),
    pageBuilder: (context, animation1, animation2) => const NoWidget(),
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: AlertDialog(
            backgroundColor: transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
            titlePadding: noPadding,
            actionsPadding: noPadding,
            contentPadding: noPadding,
            //
            content: Planet(
              width: double.maxFinite,
              padding: padS(),
              blurred: true,
              showBorder: true,
              borderWidth: 1.1,
              borderColor: styler.appColor(isDark() ? 1 : 6),
              color: styler.primaryColor(),
              maxHeight: 70.h,
              maxWidth: maxWidth ?? (isPhone() ? double.infinity : webMaxDialogWidth),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  if (title != null || showClose)
                    Planet(
                      color: showTitleColor ? styler.appColor(0.3) : transparent,
                      padding: titlePadding ?? padC('l8,r4,t4,b4'),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // title
                          if (title != null)
                            Expanded(
                              child: Padding(
                                padding: padC('t2'),
                                child: title.runtimeType == String
                                    ? AppText(
                                        title,
                                        color: styler.textColor(),
                                        size: mediumNormal,
                                      )
                                    : title,
                              ),
                            ),
                          //close
                          if (showClose)
                            Planet(
                              onPressed: () => popWhatsOnTop(),
                              padding: padS(),
                              isSquare: true,
                              noStyling: true,
                              color: styler.appColor(0.5),
                              child: AppIcon(closeIcon, size: 16, faded: true),
                            ),
                          //
                        ],
                      ),
                    ),
                  // content
                  if (content != null)
                    Flexible(
                      child: Padding(
                        padding: contentPadding ?? padM(),
                        child: content,
                      ),
                    ),
                  // actions
                  if (actions != null)
                    Padding(
                      padding: padS(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: actions,
                      ),
                    ),
                  //
                ],
              ),
            ),
            //
          ),
        ),
      );
    },
  );
}
