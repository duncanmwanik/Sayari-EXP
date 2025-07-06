import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../_helpers/nav/navigation.dart';
import '../../_helpers/ui/ui.dart';
import '../../_state/_providers.dart';
import '../../_state/theme.dart';
import '../../_theme/breakpoints.dart';
import '../../_theme/helpers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/navigation.dart';
import '../../features/notes/state/sheet.dart';
import '../others/divider.dart';

Future<void> showAppBottomSheet({
  String? title,
  Widget? header,
  required Widget content,
  Widget? footer,
  bool isShort = false,
  bool isFull = false,
  bool showBottomDivider = false,
  bool showBlur = false,
  bool constrainContent = true,
  bool popOutside = true,
  Color? color,
  EdgeInsets? contentPadding,
  EdgeInsets? footerPadding,
  FutureOr<void> Function()? whenComplete,
  FutureOr<dynamic> Function(dynamic)? then,
}) async {
  // we record that the bottom sheet is open
  state.global.updateIsBottomSheetOpen(true);
  changeStatusAndNavigationBarColor(getThemeType(), isSecondary: true);
  if (title != null) setWindowTitle(title);

  await showModalBottomSheet(
      context: navigatorState.currentContext!,
      isScrollControlled: true,
      useSafeArea: true,
      elevation: 10,
      barrierColor: black.withOpacity(0.8),
      backgroundColor: transparent,
      constraints: isShort ? BoxConstraints(maxHeight: 70.h) : BoxConstraints.expand(),
      //
      builder: (context) {
        return Consumer2<SheetProvider, ThemeProvider>(
          builder: (context, sheet, theme, child) {
            bool isMin = !isFull && isSmallPC() && sheet.isMin;

            return TapRegion(
              onTapOutside: popOutside ? (event) => popWhatsOnTop() : null,
              child: Card(
                elevation: 0,
                color: color ?? (isImage() || isBlack() || showBlur ? white.withOpacity(0.01) : styler.primaryColor()),
                margin: isMin ? pad(l: 17.w, r: 17.w, t: 5.h, b: 5.h) : noPadding,
                shape: RoundedRectangleBorder(
                  borderRadius: isShort || isMin ? BorderRadius.circular(borderRadiusSmall) : BorderRadius.zero,
                ),
                child: Column(
                  children: [
                    // header ----------
                    if (header != null)
                      Padding(
                        padding: padMS('lrt'),
                        child: header,
                      ),
                    // content ----------
                    Expanded(
                      child: ConstrainedBox(
                        constraints: constrainContent ? BoxConstraints(maxWidth: webSuperMaxWidth) : BoxConstraints(),
                        child: Padding(
                          padding: contentPadding ?? pad(p: isPhone() ? 10 : 20, s: 'lr'),
                          child: content,
                        ),
                      ),
                    ),
                    // footer ----------
                    if (footer != null)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (showBottomDivider) AppDivider(),
                          Padding(
                            padding: footerPadding ?? padS(),
                            child: footer,
                          ),
                        ],
                      )
                    //
                  ],
                ),
              ),
            );
          },
        );
      }).whenComplete(whenComplete ?? () {}).then(then ?? (_) {});

  state.global.updateIsBottomSheetOpen(false);
  changeStatusAndNavigationBarColor(getThemeType());
  if (title != null) resetWindowTitle();
}
