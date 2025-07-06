import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_state/theme.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/close.dart';
import '../../_widgets/others/about_app.dart';
import '../../_widgets/others/scroll.dart';
import '../../_widgets/others/text.dart';
import '../../_widgets/sheets/sheet.dart';
import 'w/account.dart';
import 'w/support.dart';
import 'w/theme.dart';

Future<void> showSettingsBottomSheet() async {
  await showAppBottomSheet(
      isFull: true,
      title: 'Account & Settings',
      header: Consumer<ThemeProvider>(
        builder: (context, theme, child) => Row(
          children: [
            AppCloseButton(isX: false),
            spw(),
            Expanded(child: AppText('Account & Settings', size: normal)),
            spw(),
            AppCloseButton(),
          ],
        ),
      ),
      //
      content: Consumer<ThemeProvider>(
        builder: (context, theme, child) => ConstrainedBox(
          constraints: BoxConstraints(maxWidth: webMaxWidth),
          child: NoScrollBars(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //
                  sph(),
                  AccountDetails(),
                  sph(),
                  ThemeSettings(),
                  mph(),
                  AccountSupport(),
                  //
                  AboutApp(),
                  //
                ],
              ),
            ),
          ),
        ),
      ));
}
