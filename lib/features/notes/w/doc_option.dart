import 'package:flutter/material.dart';

import '../../../_state/_providers.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/_widgets.dart';

class DocOption extends StatelessWidget {
  const DocOption(this.feature, {super.key});

  final String feature;

  @override
  Widget build(BuildContext context) {
    bool isSelected = state.views.docView == feature;
    return Planet(
      onPressed: () {
        if (state.views.docView != feature) state.views.updateDocView(feature);
      },
      color: isSelected ? styler.appColor(1) : styler.appColor(0.5),
      svp: true,
      showBorder: isSelected,
      borderWidth: 1.1,
      borderColor: styler.accent(3),
      child: AppText(feature),
    );
  }
}
