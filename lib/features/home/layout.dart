import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../_services/activity/listen/helpers.dart';
import '../../_services/hive/boxes.dart';
import '../../_state/theme.dart';
import '../../_theme/background.dart';
import '../../_variables/constants.dart';
import '../../_widgets/others/scroll.dart';
import '../user/_helpers/helpers.dart';
import 'appbar.dart';
import 'panel/panel.dart';
import 'view.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: ValueListenableBuilder(
          valueListenable: globalBox.listenable(keys: ['${liveUser()}_$currentSpace']),
          builder: (context, box, widget) {
            initializeSpaceSync();

            return Consumer<ThemeProvider>(builder: (context, theme, child) {
              return SafeArea(
                child: Row(
                  children: [
                    //
                    Panel(),
                    //
                    Expanded(
                        child: Column(
                      children: [
                        CustomAppBar(),
                        Expanded(child: NoScrollBars(child: AppView())),
                      ],
                    )),
                    //
                  ],
                ),
              );
            });
          }),
    );
  }
}
