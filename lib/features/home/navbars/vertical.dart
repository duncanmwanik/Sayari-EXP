import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../_services/hive/store.dart';
import '../../../_state/views.dart';
import '../../../_theme/spacing.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import 'nav_item.dart';

class VeticalNavigation extends StatelessWidget {
  const VeticalNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: local(info).listenable(),
        builder: (context, box, widget) {
          //
          return Consumer<ViewsProvider>(builder: (context, views, child) {
            return Padding(
              padding: padC('t12,b8'),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  NavItem(features.timeline),
                  NavItem(features.docs),
                  NavItem(features.calendar),
                  NavItem(features.chat),
                  // if (kDebugMode) NavItem(features.ghost),
                  //
                ],
              ),
            );
          });
        });
  }
}
