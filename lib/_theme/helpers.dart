import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../_services/hive/boxes.dart';
import '../_state/_providers.dart';
import 'colors.dart';
import 'styler.dart';
import 'variables.dart';

void changeStatusAndNavigationBarColor(String theme, {bool isSecondary = false}) {
  if (kIsWeb) return;

  bool isDark = isDarkTheme(theme);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      //
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarColor: isSecondary
          ? styler.secondaryColor()
          : isImage()
              ? styler.appColor(0)
              : isBlack()
                  ? black
                  : isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
      //
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isSecondary
          ? styler.secondaryColor()
          : isImage()
              ? styler.appColor(7)
              : isBlack()
                  ? black
                  : isDark
                      ? AppColors.darkPrimary
                      : AppColors.lightPrimary,
      //
    ),
  );
}

bool isLight() => 'light' == state.theme.themeType;
bool isDark() => 'dark' == state.theme.themeType;
bool isDarkOnly() => 'dark' == state.theme.themeType && !isImage() && !isBlack();
bool isBlack() => 'black' == state.theme.themeImage;
bool isImage() => !['dark', 'light', 'black'].contains(state.theme.themeImage);

String getThemeImage(String themeImage) => 'assets/images/$themeImage.jpg';
String getThemeType() => settingBox.get('themeType', defaultValue: 'dark');
bool isDarkTheme(String theme) => theme == 'dark';

Color hex(String value) => Color(int.parse('0xff$value'));

bool hasColour(String? bgColor) {
  if (bgColor == null || bgColor.isEmpty || !backgroundColors.containsKey(bgColor)) {
    return false;
  } else {
    return true;
  }
}

BoxConstraints constrain({double? maxWidth, double? maxHeight, double? minWidth, double? minHeight}) {
  return BoxConstraints(
    maxWidth: maxWidth ?? double.maxFinite,
    maxHeight: maxHeight ?? double.maxFinite,
    minWidth: minWidth ?? 0,
    minHeight: minHeight ?? 0,
  );
}

void quickSwitchThemes() {
  if (state.theme.themeImage == 'light') {
    state.theme.setThemeImage('dark', 'dark', state.theme.themeAccent);
  } else {
    state.theme.setThemeImage('light', 'light', state.theme.themeAccent);
  }
}
