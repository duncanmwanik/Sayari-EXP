import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../notes/w/picker_type.dart';
import '../_helpers/common.dart';
import '../_helpers/members.dart';
import '../var/variables.dart';

class SpaceMember extends StatelessWidget {
  const SpaceMember({super.key, required this.userEmail, required this.userId, required this.spaceId});

  final String userEmail;
  final String userId;
  final String spaceId;

  @override
  Widget build(BuildContext context) {
    return Planet(
        onPressed: null,
        noStyling: true,
        showBorder: true,
        margin: padC('b5'),
        padding: padS(),
        borderWidth: 0.5,
        radius: borderRadiusSmall + 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            // initials
            Planet(
              height: 25,
              width: 25,
              isSquare: true,
              padding: noPadding,
              child: Center(
                child: AppIcon(
                  Icons.person,
                  size: small,
                  faded: true,
                ),
              ),
            ),
            mspw(),
            // email
            Expanded(child: AppText(userEmail)),
            // change priviledges
            isSuperAdmin(userId)
                ? Planet(
                    noStyling: true,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcon(Icons.lock, size: small, color: styler.accent()),
                        spw(),
                        AppText('Owner', size: small, color: styler.accent()),
                      ],
                    ),
                  )
                : AppTypePicker(
                    type: features.calendar,
                    subType: 'y',
                    initial: memberPriviledges[getMemberPriviledge(userId)],
                    typeEntries: memberPriviledges,
                    onSelect: (chosenKey, chosenValue) =>
                        getMemberPriviledge(userId) == chosenKey ? null : changeMemberPriviledge(userId, chosenKey),
                    borderRadius: borderRadiusLarge,
                    color: styler.appColor(0.4),
                  ),
            // remove person
            if (isAdmin() && !isSuperAdmin(userId))
              Planet(
                onPressed: () => removeMemberFromSpace(userId, userEmail),
                noStyling: true,
                isSquare: true,
                margin: padT('l'),
                child: AppIcon(closeIcon, faded: true, size: normal),
              )
          ],
        ));
  }
}
