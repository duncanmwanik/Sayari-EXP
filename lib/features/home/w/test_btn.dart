import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/toast.dart';

class TestButton extends StatelessWidget {
  const TestButton({super.key, this.extended = true});

  final bool extended;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: kDebugMode,
      child: Planet(
        onPressed: () async =>
            toastInfo('Failed to be happy.', description: 'This might be caused by the utter sham and sadness that humanity harbors.'),
        noStyling: true,
        isRound: true,
        content: Icons.lightbulb,
        faded: true,
      ),
    );
  }
}
