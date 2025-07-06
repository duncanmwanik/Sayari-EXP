import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../view.dart';

class AlternateView extends StatelessWidget {
  const AlternateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padC('l2,r2,t4,b2'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          DocView(),
          //
        ],
      ),
    );
  }
}
