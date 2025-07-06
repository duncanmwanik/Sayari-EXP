import 'package:flutter/material.dart';

import '../../../_helpers/common/global.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../auth/_helpers/sign_out.dart';

class DemoButton extends StatelessWidget {
  const DemoButton({super.key, this.extended = true});

  final bool extended;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isDemo(),
      child: Planet(
        onPressed: () async => await signOutUser(),
        margin: padM('r'),
        textColor: styler.accent(),
        srp: true,
        radius: borderRadiusLarge,
        content: 'Leave Demo',
        trailing: Icons.arrow_forward,
      ),
    );
  }
}
