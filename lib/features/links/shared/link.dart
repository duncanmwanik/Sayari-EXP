import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../_models/item.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/text.dart';
import '../../share/w_shared/socials.dart';
import '../_helpers/helpers.dart';
import 'link_cover.dart';

class SharedLink extends StatelessWidget {
  const SharedLink({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    bool isTitle = item.typee() != itemLinkTypeLink;

    return Planet(
      onPressed: isTitle ? null : () => openLink(item.content()),
      margin: isTitle ? padC('t12,b4') : null,
      padding: padC(isTitle ? 'l4,r4,t4' : 'l4,r4,t4,b4'),
      maxWidth: phoneWidth,
      noStyling: isTitle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // image or icon
          if (!isTitle) SharedLinkCover(item: item),
          // title
          Expanded(
            child: AppText(
              item.title(),
              size: normal,
              weight: isTitle ? ft5 : ft5,
              textAlign: TextAlign.center,
              padding: padL('lr'),
            ),
          ),
          //
          if (!isTitle) ShareToSocials(title: item.title(), link: item.content(), isShareIcon: false),
          //
        ],
      ),
    ).animate().scaleY();
  }
}
