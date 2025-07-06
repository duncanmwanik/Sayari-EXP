import 'package:flutter/material.dart';

import '../../../../_theme/spacing.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/others/divider.dart';
import '../../../_widgets/others/text.dart';

class TimelineTile extends StatelessWidget {
  const TimelineTile({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padL('b'),
      child: Theme(
        data: expansionTileThemeData,
        child: ExpansionTile(
          dense: true,
          initiallyExpanded: globalBox.get('expand$title', defaultValue: true),
          onExpansionChanged: (value) => globalBox.put('expand$title', value),
          tilePadding: padM('lr'),
          childrenPadding: padM('t'),
          clipBehavior: Clip.none,
          expandedAlignment: Alignment.topLeft,
          collapsedShape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusSmall)),
          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusSmall)),
          iconColor: styler.textColor(extraFaded: true),
          collapsedIconColor: styler.textColor(extraFaded: true),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText(title, faded: true, size: small),
              tph(),
              AppDivider(),
            ],
          ),
          children: children,
        ),
      ),
    );
  }
}
