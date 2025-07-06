import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/files/cover.dart';
import '../../../_widgets/others/list.dart';
import '../../../_widgets/others/text.dart';

class LinksOverview extends StatelessWidget {
  const LinksOverview({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    List linkKeys = item.sharedlinks();

    return Padding(
      padding: padL('t'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Cover(item: item, size: 60),
          msph(),
          //
          AppScroll(
            scroll: false,
            children: List.generate(linkKeys.length, (index) {
              Item link = Item(id: linkKeys[index], data: item.data[linkKeys[index]]);
              bool isTitle = link.typee() == itemLinkTypeTitle;

              return Planet(
                margin: padT('t'),
                noStyling: isTitle,
                color: styler.appColor(isDark() ? 0.1 : 0.6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: AppText(link.title(), size: tiny, extraFaded: true),
                    ),
                  ],
                ),
              );
            }),
          ),
          //
        ],
      ),
    );
  }
}
