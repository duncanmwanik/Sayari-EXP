import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/planet.dart';
import 'doc_option.dart';

class DocOptions extends StatelessWidget {
  const DocOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Planet(
        blurred: true,
        noStyling: true,
        margin: padM('lrb'),
        padding: padS(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: tw(),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              for (String f in features.personal()) DocOption(f),
              //
            ],
          ),
        ),
      ),
    );
  }
}
