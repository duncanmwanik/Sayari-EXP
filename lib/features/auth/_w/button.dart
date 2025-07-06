import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/images.dart';
import '../../../_widgets/others/loader.dart';
import '../../../_widgets/others/text.dart';
import '../state/auth.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.label,
    this.imagePath,
    this.iconData = Icons.arrow_forward,
    required this.onPressed,
    this.isMain = false,
  });

  final String label;
  final String? imagePath;
  final IconData iconData;
  final Function()? onPressed;
  final bool isMain;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthorityProvider>(builder: (context, auth, child) {
      return Planet(
        onPressed: onPressed,
        maxWidth: isMain ? 300 : null,
        padding: padMN(),
        radius: borderRadiusLarge,
        hoverColor: isDark() ? const Color.fromARGB(31, 0, 0, 0) : null,
        showBorder: isLight() && !isMain,
        color: isMain ? styler.accent() : white,
        child: auth.isBusy && auth.process == label
            ? Center(child: AppLoader(color: isMain ? white : styler.accent()))
            : auth.isSuccessful && auth.process == label
                ? Center(child: AppIcon(Icons.check_circle, color: white))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // brand
                      if (imagePath != null) AppImage(imagePath ?? '', size: normal),
                      if (imagePath != null) spw(),
                      // label
                      Flexible(
                        child: AppText(
                          label,
                          weight: isMain ? ft6 : ft5,
                          color: isMain ? white : black,
                        ),
                      ),
                      // icon
                      if (imagePath == null) spw(),
                      if (imagePath == null)
                        AppIcon(
                          Icons.arrow_forward,
                          size: normal,
                          color: isMain ? white : black,
                        ),
                    ],
                  ),
      );
    });
  }
}
