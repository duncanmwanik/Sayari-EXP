import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import 'add_member.dart';

class SharePolicy extends StatelessWidget {
  const SharePolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // shared to restricted
          Planet(
            onPressed: () => input.update(itemShared, itemSharedRestricted),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadiusSmall),
              bottomLeft: Radius.circular(borderRadiusSmall),
            ),
            svp: true,
            showBorder: true,
            color: input.item.isSharedRestricted() ? styler.accent(6) : null,
            child: AppText(itemSharedRestricted.cap()),
          ),
          pw(1),
          // shared to public
          Planet(
            onPressed: () => input.update(itemShared, itemSharedPublic),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(borderRadiusSmall),
              bottomRight: Radius.circular(borderRadiusSmall),
            ),
            svp: true,
            showBorder: true,
            color: input.item.isSharedPublic() ? styler.accent(6) : null,
            child: AppText(itemSharedPublic.cap()),
          ),
          // add user
          if (input.item.isSharedRestricted())
            Planet(
              onPressed: () async => await showAddSharedMemberDialog(),
              slp: true,
              svp: true,
              showBorder: true,
              margin: padM('l'),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIcon(Icons.add, size: normal, faded: true),
                  tpw(),
                  Flexible(child: AppText('Add User', size: small)),
                ],
              ),
            ),
          //
          AppText(
            input.item.isSharedPublic() ? 'Anyone with the link has access.' : 'Only added users will have access.',
            faded: true,
            padding: padM('l'),
          ),
          //
        ],
      );
    });
  }
}
