import 'package:flutter/material.dart';

import '../../../../_theme/breakpoints.dart';
import '../../../../_theme/helpers.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/others/divider.dart';
import '../../../../_widgets/others/scroll.dart';
import '../../../notes/view.dart';
import '../../../share/w_shared/header.dart';
import 'shared_intro.dart';

class PublishBookBody extends StatelessWidget {
  const PublishBookBody({super.key});

  @override
  Widget build(BuildContext context) {
    return NoScrollBars(
      child: Column(
        children: [
          //
          SharedHeader(),
          //
          Expanded(
            child: !isSmallPC()
                ? Padding(
                    padding: pad(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        mph(),
                        PublishedBookIntro(),
                        mph(),
                        AppDivider(),
                        mph(),
                        Flexible(
                          child: DocView(),
                        ),
                      ],
                    ),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: padN('lt'),
                        child: PublishedBookIntro(),
                      ),
                      Expanded(
                          child: Container(
                        // margin: padN( 'l'),
                        // padding: padN( 'ltr'),
                        decoration: BoxDecoration(
                          border: Border(left: BorderSide(color: styler.borderColor(), width: isDark() ? 0.5 : 1)),
                        ),
                        child: DocView(),
                      )),
                    ],
                  ),
          ),
          //
        ],
      ),
    );
  }
}
