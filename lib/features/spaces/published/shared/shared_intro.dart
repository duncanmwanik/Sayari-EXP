import 'package:flutter/material.dart';

import '../../../../../../_widgets/others/text.dart';
import '../../../../_state/_providers.dart';
import '../../../../_theme/breakpoints.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../user/dp.dart';
import 'cover.dart';

class PublishedBookIntro extends StatelessWidget {
  const PublishedBookIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: !isSmallPC() ? double.infinity : 300),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusSmall),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            PublishedCover(),
            //
            mph(),
            AppText(
              state.share.item.title(),
              // 'Being Mortal: Medicine and What Matters in the End',
              size: extra,
              weight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            sph(),
            Container(
              width: 30,
              height: 3,
              decoration: BoxDecoration(
                color: styler.accent(),
                borderRadius: BorderRadius.circular(borderRadiusLarge),
              ),
            ),
            tph(),
            Planet(
              onPressed: () {},
              noStyling: true,
              svp: true,
              slp: true,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UserDp(onPressed: () {}, userId: state.share.item.sharedCreator(), isTiny: true, size: tiny),
                  spw(),
                  Flexible(child: AppText('User X', size: small)),
                ],
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
