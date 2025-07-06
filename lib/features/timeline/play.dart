// ignore_for_file: dead_code

import 'package:flutter/material.dart';

import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/jj.dart';
import '../../_widgets/editor/editor.dart';
import '../../_widgets/others/blur.dart';
import '../../_widgets/others/images.dart';
import '../../_widgets/others/text.dart';

class PlayView extends StatelessWidget {
  const PlayView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padSL(),
      child: Center(
        child: Wrap(
          spacing: sw(),
          runSpacing: sw(),
          children: [
            //
            Container(
              height: 200,
              width: 500,
              decoration: BoxDecoration(
                color: styler.appColor(1),
                borderRadius: BorderRadius.circular(borderRadiusTiny),
                border: Border.all(color: styler.borderColor(), width: 0.9),
              ),
              child: Center(
                child: AppText('Hello Me'),
              ),
            ),
            //
          ],
        ),
      ),
    );

    return Stack(
      children: [
        AppImage('mars.jpg', width: double.infinity, height: double.infinity),
        Center(
          child: Blur(
            blur: 30,
            radius: 0,
            child: Container(
              color: Color.alphaBlend(Colors.orange.withOpacity(0.25), Colors.black.withOpacity(0.4)),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        )
      ],
    );
    return SingleChildScrollView(
      padding: padSL(),
      child: AppEditor(json: jj),
    );
  }
}
