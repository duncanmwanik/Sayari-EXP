import 'package:flutter/material.dart';

import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import 'social.dart';

class SharedSocials extends StatelessWidget {
  const SharedSocials({super.key});

  @override
  Widget build(BuildContext context) {
    List socialKeys = state.share.item.sharedSocials();

    return Padding(
      padding: padL('b'),
      child: Wrap(
        spacing: tw(),
        runSpacing: tw(),
        children: [
          //
          for (String id in socialKeys) SharedSocial(id: id),
          //
        ],
      ),
    );
  }
}
