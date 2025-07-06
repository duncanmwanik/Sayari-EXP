import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../_state/_providers.dart';
import '../../_theme/helpers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_widgets/_widgets.dart';
import '../../_widgets/others/list.dart';
import '_helpers/demo_signin.dart';
import '_helpers/email_signin.dart';
import '_helpers/email_signup.dart';
import '_helpers/google_signin.dart';
import '_helpers/reset.dart';
import '_w/button.dart';
import 'auth_more.dart';
import 'cancel.dart';
import 'forms.dart';
import 'state/auth.dart';
import 'terms.dart';
import 'var/var.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  void initState() {
    changeStatusAndNavigationBarColor(getThemeType());
    if (kDebugMode) state.input.update(itemEmail, demoEmail, notify: false);
    if (kDebugMode) state.input.update(itemPassword, demoPass, notify: false);
    signInWithGoogle(silently: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthorityProvider>(builder: (context, auth, child) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppImage('assets/images/sayari.png', size: 26),
                    spw(),
                    Flexible(child: AppText('Sayari', size: 24, mildFaded: true, weight: ft8)),
                  ],
                ).animate(delay: Duration(milliseconds: 900)).slideY(),
                sph(),
                AppText('A minimalist toolset', extraFaded: true, size: 14, weight: ft6)
                    .animate(delay: Duration(milliseconds: 300))
                    .slideY(),
              ],
            ),
            lph(),
            //
            Planet(
              showBorder: isLight(),
              padding: padL(),
              margin: padL(),
              radius: borderRadiusLarge + 8,
              color: styler.appColor(0.5),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: AppScroll(
                  padding: padL(),
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //
                    AuthCancel(),
                    //
                    if (!auth.isSignUp() && !auth.isResetPass())
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //
                          SignInButton(
                            onPressed: () async => await signInWithGoogle(),
                            imagePath: 'google.png',
                            label: authGoogleLabel,
                          ),
                          ph(6),
                          SignInButton(
                            onPressed: () async => await signInDemo(),
                            imagePath: 'sayari.png',
                            label: authDemoLabel,
                          ),
                          //
                          ph(12),
                          AppText('OR', size: small, extraFaded: true),
                          ph(6),
                          //
                        ],
                      ),
                    //
                    AuthForms(),
                    ph(12),
                    // action button
                    if (auth.isSignIn() || auth.showAll())
                      SignInButton(
                        onPressed: () async => await signInWithEmailPassword(),
                        label: authSignInLabel,
                        isMain: true,
                      ),
                    if (auth.isSignUp())
                      SignInButton(
                        onPressed: () async => await signUpWithEmailPassword(),
                        label: authSignUpLabel,
                        isMain: true,
                      ),
                    if (auth.isResetPass())
                      SignInButton(
                        onPressed: () async => await resetPassword(),
                        label: authResetPassLabel,
                        isMain: true,
                      ),
                    //
                    mph(),
                    AuthMore(),
                    mlph(),
                    AuthTerms(),
                    //
                  ],
                ),
              ),
            ).animate().fadeIn(),
            //
          ],
        ),
      );
    });
  }
}
