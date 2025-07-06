import 'package:flutter/material.dart';

import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/menu/menu_item.dart';
import '../../../../_widgets/menu/model.dart';
import '../../../../_widgets/others/future.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/loader.dart';
import '../../../../_widgets/others/other.dart';
import '../../../user/_helpers/actions.dart';
import '../../_helpers/common.dart';
import '../../_helpers/delete.dart';
import '../../overview/overview_sheet.dart';

class SpaceOptions extends StatelessWidget {
  const SpaceOptions({super.key, required this.spaceId, required this.spaceName, required this.groupId});

  final String spaceId;
  final String spaceName;
  final String groupId;

  @override
  Widget build(BuildContext context) {
    bool isNotDefaultSpace = !isDefaultSpace(spaceId);

    return Planet(
      menu: Menu(
        items: [
          //
          MenuItem(label: spaceName, faded: true, sh: true, popTrailing: true),
          menuDivider(),
          //
          if (isLiveSpace(spaceId))
            MenuItem(
              label: 'Manage Space',
              leading: Icons.stacked_bar_chart_rounded,
              onTap: () => showSpaceOverviewBottomSheet(),
            ),
          //
          MenuItem(
            label: 'Add To Group',
            leading: Icons.drive_folder_upload_rounded,
            onTap: () => addSpaceToGroup(spaceId),
          ),
          //
          if (groupId.isNotEmpty)
            MenuItem(
              label: 'Remove From Group',
              leading: Icons.folder_off_rounded,
              onTap: () => removeSpaceFromGroup(spaceId, groupId),
            ),
          //
          if (isNotDefaultSpace)
            AppFuture(
              future: isOwner(spaceId),
              loadingWidget: AppLoader(isLinear: true),
              errorWidget: NoWidget(),
              widget: (isOwner) => isOwner
                  ? MenuItem(
                      label: 'Delete Space',
                      leading: Icons.delete_forever_rounded,
                      onTap: () => deleteSpace(spaceId),
                    )
                  : MenuItem(
                      label: 'Remove Space',
                      leading: Icons.remove_circle_outlined,
                      onTap: () => removeSpace(spaceId),
                    ),
            ),
          //
        ],
      ),
      noStyling: true,
      isSquare: true,
      child: AppIcon(moreIcon, extraFaded: true, size: 18),
    );
  }
}
