import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../_state/theme.dart';
import '../_variables/constants.dart';
import '../_widgets/files/image.dart';
import '../_widgets/others/other.dart';
import 'helpers.dart';
import 'variables.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    this.fit,
    required this.child,
  });

  final BoxFit? fit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // background color
        Consumer<ThemeProvider>(
          builder: (context, theme, child) {
            return Container(color: styler.primaryColor());
          },
        ),
        // background image
        Consumer<ThemeProvider>(builder: (context, theme, child) {
          return isImage()
              ? ImageFile(
                  theme.themeImage,
                  '${theme.themeImage}.jpg',
                  db: def,
                  space: background,
                  offline: true,
                  fit: fit ?? BoxFit.fill,
                  width: double.maxFinite,
                  height: double.maxFinite,
                  ignore: true,
                  showOptions: false,
                  showLoading: false,
                  radius: 0,
                )
              : NoWidget();
        }),
        // content
        child
        //
      ],
    );
  }
}
