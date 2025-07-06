import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_services/cloud/get_space_data.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_services/hive/store.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/divider.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/scroll.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/common.dart';
import '../_helpers/members.dart';
import 'add_member.dart';
import 'member.dart';

class SpaceMembers extends StatelessWidget {
  const SpaceMembers({super.key});

  @override
  Widget build(BuildContext context) {
    String spaceId = liveSpace();

    return Padding(
      padding: padLL('t'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          AppText('Members', size: small, faded: true),
          AppDivider(height: mh()),
          //
          if (isAdmin())
            Align(
              alignment: Alignment.topRight,
              child: Planet(
                onPressed: () async => await showAddAdminDialog(),
                slp: true,
                noStyling: true,
                margin: padM('b'),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(Icons.add_rounded, size: extra),
                    tspw(),
                    AppText('Add Member'),
                  ],
                ),
              ),
            ),
          //
          NoOverScroll(
            child: ValueListenableBuilder(
                valueListenable: local('members', space: spaceId).listenable(),
                builder: (context, box, widget) {
                  Map memberData = box.toMap();
                  if (memberData.isEmpty) {
                    getSpaceMemberData(spaceId);
                  }

                  return Wrap(
                    children: List.generate(memberData.length, (index) {
                      String userId = memberData.keys.toList()[index];
                      if (userEmailsBox.get(userId, defaultValue: null) == null) {
                        getAdminEmail(userId);
                      }

                      return SpaceMember(
                        spaceId: spaceId,
                        userEmail: userEmailsBox.get(userId, defaultValue: '---'),
                        userId: userId,
                      );
                    }),
                  );
                }),
          ),
          //
        ],
      ),
    );
  }
}
