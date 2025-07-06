import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/divider_vertical.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import 'state/auth.dart';
import 'var/var.dart';

class AuthMore extends StatelessWidget {
  const AuthMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthorityProvider>(builder: (context, auth, child) {
      return Visibility(
        visible: !auth.isSignUp() && !auth.isResetPass(),
        child: Padding(
          padding: padS('t'),
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                Planet(
                  onPressed: () {
                    auth.setProcess(authResetPassLabel, false);
                    authFormKey.currentState!.reset();
                  },
                  noStyling: true,
                  radius: borderRadiusLarge,
                  child: AppText('Forgot password?', mildFaded: true),
                ),
                //
                AppSeparator(),
                //
                Planet(
                  onPressed: () {
                    auth.setProcess(authSignUpLabel, false);
                    authFormKey.currentState!.reset();
                  },
                  slp: true,
                  noStyling: true,
                  borderWidth: 0.3,
                  radius: borderRadiusLarge,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcon(addIcon, size: normal, faded: true),
                      spw(),
                      Flexible(child: AppText('Create Account', mildFaded: true)),
                    ],
                  ),
                ),
                //
              ],
            ),
          ),
        ),
      );
    });
  }
}
