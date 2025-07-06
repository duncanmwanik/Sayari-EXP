import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../_helpers/extentions/strings.dart';
import '../../_state/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/text.dart';
import '../user/dp.dart';
import 'actions.dart';

class BlogInfo extends StatelessWidget {
  const BlogInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // dp
        UserDp(
          onPressed: () {},
          userId: state.share.item.sharedCreator(),
          isTiny: true,
          size: largeTitle,
        ),
        spw(),
        //
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // username
            Planet(
              onPressed: () {},
              noStyling: true,
              padding: EdgeInsets.zero,
              hoverColor: transparent,
              child: AppText('User X', size: medium, overflow: TextOverflow.ellipsis),
            ),
            // timestamp
            AppText(
              state.share.item.timestamp().stampToTime(),
              size: small,
              faded: true,
              overflow: TextOverflow.ellipsis,
            ),
            //
          ],
        )),
        //
        mph(),
        SharedActions(id: state.share.item.id, userId: state.share.item.sharedCreator()),
        //
      ],
    );
  }
}
