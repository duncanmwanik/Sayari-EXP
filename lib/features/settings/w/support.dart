import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_helpers/common/url_launcher.dart';
import '../../../_services/hive/store.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../auth/_helpers/sign_out.dart';
import '../../user/_helpers/helpers.dart';
import 'title.dart';

class AccountSupport extends StatelessWidget {
  const AccountSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: local('', space: liveUser()).listenable(),
        builder: (context, box, widget) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              SettingTitle('SUPPORT'),
              sph(),
              Planet(
                onPressed: () => sendFeedbackDialog(),
                leading: 'Send Feedback',
                trailing: Icons.keyboard_arrow_right_rounded,
                expand: true,
                color: styler.appColor(0.7),
                height: 35,
              ),
              tsph(),
              Planet(
                onPressed: () => signOutUser(),
                leading: 'Sign Out',
                trailing: Icons.exit_to_app_rounded,
                faded: true,
                expand: true,
                color: styler.appColor(0.7),
                height: 35,
              ),
              //
            ],
          );
        });
  }
}
