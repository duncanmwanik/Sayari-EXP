import 'package:flutter/material.dart';

import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/others/blur.dart';
import '../../../_widgets/others/scroll.dart';
import '../../share/w_shared/escape.dart';
import 'intro.dart';
import 'links.dart';
import 'socials.dart';

class LinksBody extends StatelessWidget {
  const LinksBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //
        Blur(
          enabled: state.share.item.hasCover(),
          blur: 1000,
          width: double.infinity,
          height: double.infinity,
          child: NoScrollBars(
            child: SingleChildScrollView(
              padding: pad(
                t: lh(),
                b: lh(),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  elph(),
                  LinksIntro(),
                  lph(),
                  SharedSocials(),
                  SharedLinks(),
                  lph(),
                  ShareEscape(),
                  //
                ],
              ),
            ),
          ),
        ),
        //
      ],
    );
  }
}
