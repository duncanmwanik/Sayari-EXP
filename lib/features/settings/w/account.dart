import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_helpers/common/global.dart';
import '../../../_services/hive/store.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/divider_vertical.dart';
import '../../../_widgets/others/text.dart';
import '../../auth/_helpers/reset.dart';
import '../../user/_helpers/helpers.dart';
import '../../user/dp.dart';
import '../../user/dp_menu.dart';
import '../../user/w/edit_username.dart';
import 'title.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: local('', space: liveUser()).listenable(),
        builder: (context, box, widget) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Center(
                child: UserDp(
                  showDpOptions: !isDemo(),
                  menu: dpEditMenu(),
                  size: 120,
                ),
              ),
              mph(),
              SettingTitle('ACCOUNT'),
              sph(),
              Planet(
                leading: 'Name',
                trailing: AppText(liveUserName()),
                expand: true,
                color: styler.appColor(0.7),
                height: 35,
              ),
              tsph(),
              Planet(
                leading: 'Email',
                trailing: liveUserEmail(),
                expand: true,
                color: styler.appColor(0.7),
                height: 35,
              ),
              tsph(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Planet(
                    onPressed: () => showEditUsernameDialog(),
                    iconSize: mediumSmall,
                    noStyling: true,
                    faded: true,
                    content: 'Change Name',
                  ),
                  AppSeparator(),
                  Planet(
                    onPressed: () => quickResetPassword(),
                    iconSize: mediumSmall,
                    noStyling: true,
                    textColor: red,
                    content: 'Reset Password',
                  ),
                ],
              ),
              //
            ],
          );
        });
  }
}
