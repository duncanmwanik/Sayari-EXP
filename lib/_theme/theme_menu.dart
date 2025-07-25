import 'package:flutter/material.dart';

import '../_helpers/extentions/strings.dart';
import '../_helpers/nav/navigation.dart';
import '../_state/_providers.dart';
import '../_variables/constants.dart';
import '../_widgets/buttons/planet.dart';
import '../_widgets/files/image.dart';
import '../_widgets/menu/menu_item.dart';
import '../_widgets/menu/model.dart';
import '../_widgets/others/color_item.dart';
import '../_widgets/others/divider.dart';
import '../_widgets/others/text.dart';
import 'colors.dart';
import 'spacing.dart';
import 'styler.dart';
import 'variables.dart';

Menu themeMenu() {
  Map<String, ColorObject> themeColors = {...backgroundColors};
  themeColors.removeWhere((key, value) => !value.isTheme);

  return Menu(
    width: 300, // TODO: a must for some reason
    items: [
      //
      MenuItem(label: 'Choose theme', sh: true, popTrailing: true),
      tph(),
      // theme + background images
      GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 2.8,
        children: List.generate(themeImages.length, (index) {
          String themeImage = themeImages.keys.toList()[index];
          String themeType = themeImages[themeImage] ?? 'light';
          Color color = themeType == 'light' ? black : white;
          bool isImage = !['light', 'dark', 'black'].contains(themeImage);
          bool isDark = ['dark'].contains(themeImage);
          bool isBlack = ['black'].contains(themeImage);
          bool isSelected = themeImage == state.theme.themeImage;

          return Planet(
            onPressed: () => popWhatsOnTop(todoLast: () => state.theme.setThemeImage(themeImage, themeType, state.theme.themeAccent)),
            noStyling: !isSelected,
            color: styler.accent(),
            padding: padT(),
            child: Stack(
              children: [
                isImage
                    ? ImageFile(
                        themeImage,
                        '$themeImage.jpg',
                        db: def,
                        space: background,
                        fit: BoxFit.fill,
                        width: double.maxFinite,
                        height: double.maxFinite,
                        offline: true,
                        ignore: true,
                        showOptions: false,
                        showLoading: false,
                        radius: borderRadiusTiny,
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadiusTiny),
                          border: Border.all(color: isSelected ? styler.borderColor() : transparent),
                          color: isBlack ? black : (isDark ? AppColors.darkPrimary : white),
                        ),
                      ),
                Center(child: AppText(size: small, themeImage.cap(), color: color))
              ],
            ),
          );
        }),
      ),
      //
      AppDivider(height: mh()),
      // accent colors
      GridView.count(
        shrinkWrap: true,
        mainAxisSpacing: tw(),
        crossAxisSpacing: tw(),
        crossAxisCount: 8,
        children: List.generate(themeColors.length, (index) {
          String color = themeColors.keys.toList()[index];

          return ColorItem(
            color: color,
            selectedColor: state.theme.themeAccent,
            onSelect: () {
              state.theme.setThemeImage(state.theme.themeImage, state.theme.themeType, color);
              popWhatsOnTop();
            },
          );
        }),
      ),
      //
    ],
  );
}
