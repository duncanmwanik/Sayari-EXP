import 'package:flutter/material.dart';

import '../_state/_providers.dart';
import 'colors.dart';
import 'helpers.dart';
import 'variables.dart';

class AppColors {
  static const Color accent = Colors.red;

  static const Color darkPrimary = Color(0xff1e1e1e);
  static const Color lightPrimary = Color(0xffffffff);

  static const Color darkSecondary = Color(0xff2c2c2c);
  static const Color lightSecondary = Color(0xfff2f2f2);

  static const Color darkTertiary = Color(0xff383838);
  static const Color lightTertiary = Color(0xffdfdfdf);

  static Color lightHover = const Color.fromARGB(15, 0, 0, 0);
  static Color darkHover = const Color.fromARGB(10, 255, 255, 255);

  static const Color darkText = Colors.white;
  static const Color lightText = Color(0xff333333);

  static Color darkTextMildFaded = Colors.white.withOpacity(0.9);
  static Color lightTextMildFaded = const Color(0xff333333).withOpacity(0.9);
  static Color darkTextFaded = Colors.white.withOpacity(0.7);
  static Color lightTextFaded = const Color(0xff333333).withOpacity(0.8);
  static Color darkTextExtraFaded = Colors.white.withOpacity(0.3);
  static Color lightTextExtraFaded = const Color(0xff333333).withOpacity(0.6);

  static const Color darkDividerColor = Colors.white12;
  static const Color lightDividerColor = Colors.black12;

  static const Color darkBottomNavBarColor = Color(0xff2f2f2f);
  static const Color lightBottomNavBarColor = Color(0xfff7f7f7);

  static Color textSelectionColor = accent.withOpacity(0.3);
}

class AppStyles {
  bool isDark = false;

  void initialize(bool value) {
    isDark = value;
  }

  // -------------------------- Primary Colors
  Color accent([double? opacity]) {
    return backgroundColors[state.theme.themeAccent]!.color.withOpacity((opacity ?? 10) / 10);
  }

  Color primaryColor() {
    return isDark
        ? isBlack()
            ? Colors.black
            : AppColors.darkPrimary
        : AppColors.lightPrimary;
  }

  Color secondaryColor() {
    return isDark ? AppColors.darkSecondary : AppColors.lightSecondary;
  }

  Color tertiaryColor() {
    return isDark ? AppColors.darkTertiary : AppColors.lightTertiary;
  }

  Color navColor() {
    return isImage()
        ? transparent
        : isBlack()
            ? black
            : isDark
                ? AppColors.darkPrimary
                : AppColors.lightPrimary;
  }

  Color appColor([double weight = 1]) {
    return Colors.grey.withOpacity(weight / 10);
  }

  // -------------------------- Text Colors

  Color textColor({bool mildFaded = false, bool faded = false, bool extraFaded = false, String? bgColor}) {
    if (hasColour(bgColor)) {
      return AppColors.lightText;
    } else {
      if (extraFaded) return isDark ? AppColors.darkTextExtraFaded : AppColors.lightTextExtraFaded;
      if (faded) return isDark ? AppColors.darkTextFaded : AppColors.lightTextFaded;
      if (mildFaded) return isDark ? AppColors.darkTextMildFaded : AppColors.lightTextMildFaded;
      return isDark ? AppColors.darkText : AppColors.lightText;
    }
  }

  Color invertedTextColor() => isDark ? AppColors.lightText : AppColors.darkText;

  // -------------------------- Other Colors

  Color borderColor() => isDark ? Colors.white12 : Colors.black26;

  Color? getItemColor() {
    return isImage()
        ? white.withOpacity(0.1)
        : isDark
            ? styler.appColor(0.3)
            : styler.appColor(0.1);
  }

  Color getItemBgColor(String? bgColor, bool isShade) {
    if (bgColor != null && bgColor.isNotEmpty) {
      return isShade ? backgroundColors[bgColor]!.shadeColor : backgroundColors[bgColor]!.color;
    } else {
      return isImage()
          ? white.withOpacity(0.05)
          : isBlack()
              ? styler.appColor(1.5)
              : isDark
                  ? styler.appColor(0.3)
                  : styler.appColor(0.8);
    }
  }

  Color? getBgColor(String? bgColor, {bool isShade = false}) {
    if (bgColor != null && bgColor.isNotEmpty) {
      return isShade ? backgroundColors[bgColor]!.shadeColor : backgroundColors[bgColor]!.color;
    } else {
      return null;
    }
  }

  // gradients
  Gradient gradient({
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    List<Color>? colors,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      // tileMode: TileMode.clamp,
      // stops: [0.8, 0.2],
      colors: colors ?? [styler.accent(), tertiaryColor()],
    );
  }
}
