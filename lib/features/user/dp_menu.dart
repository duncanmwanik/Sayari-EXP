import 'package:flutter/material.dart';

import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_widgets/files/_helpers/download.dart';
import '../../_widgets/files/_helpers/helper.dart';
import '../../_widgets/files/viewer.dart';
import '../../_widgets/menu/menu_item.dart';
import '../../_widgets/menu/model.dart';
import '_helpers/dp.dart';
import '_helpers/helpers.dart';

Menu dpEditMenu() {
  return Menu(
    items: [
      // edit
      MenuItem(onTap: () async => await chooseUserDp(), label: 'Edit', leading: editIcon),
      // view
      if (hasUserDp())
        MenuItem(
          onTap: () async => await showImageViewer(
            images: {userDpId(): userDpName()},
            onDownload: () async => await downloadFile(
              db: users,
              id: userDpId(),
              name: userDpName(),
              cloudFilePath: '${liveUser()}/${userDpName()}',
              downloadPath: 'dp.${getfileExtension(userDpName())}',
            ),
          ),
          label: 'View',
          leading: Icons.image_outlined,
        ),
      // remove
      if (hasUserDp()) MenuItem(onTap: () => removeUserDp(), label: 'Remove', leading: Icons.close),
      //
    ],
  );
}
