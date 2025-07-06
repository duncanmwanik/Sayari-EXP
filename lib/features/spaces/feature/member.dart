import 'package:flutter/material.dart';

import '../../../_helpers/extentions/strings.dart';
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
        margin: padC('b5'),
        padding: padS(),
        color: styler.appColor(0.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            // initial
            Planet(
              height: 25,
              width: 25,
              isSquare: true,
              padding: noPadding,
              color: userEmail.toColor(),
              child: Center(child: AppText(userEmail[0].toUpperCase(), size: small, faded: true)),
            ),
            mspw(),
            // email
            Expanded(child: AppText(userEmail)),
            // change priviledges
            isSuperAdmin(userId)
                ? Planet(
                    color: styler.accent(6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcon(Icons.lock, size: small),
                        spw(),
                        AppText('Owner', size: small),
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
                margin: padS('l'),
                child: AppIcon(closeIcon, faded: true, size: normal),
              )
          ],
        ));
  }
}
