import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/_widgets.dart';

class ManagerLoader extends StatefulWidget {
  const ManagerLoader({super.key});

  @override
  State<ManagerLoader> createState() => _ManagerLoaderState();
}

class _ManagerLoaderState extends State<ManagerLoader> with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> animation = CurvedAnimation(
    parent: controller,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Planet(
      margin: padM('b'),
      noStyling: true,
      slp: true,
      child: Row(
        children: [
          RotationTransition(
            turns: animation,
            child: AppIcon(Icons.sync, size: extra, color: styler.accent()),
          ),
          spw(),
          Flexible(
            child: AppText('Syncing your spaces'),
          ),
        ],
      ),
    ).animate().shimmer();
  }
}
