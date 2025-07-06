// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/icons.dart';
import 'intro_type.dart';
import 'var/var.dart';

class IntroFeatures extends StatefulWidget {
  const IntroFeatures({super.key});

  @override
  State<IntroFeatures> createState() => _IntroFeaturesState();
}

class _IntroFeaturesState extends State<IntroFeatures> {
  int index = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(milliseconds: 3500),
        (Timer t) => setState(() {
              index = index < introFeatures.length - 1 ? index + 1 : 0;
            }));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Planet(
      radius: 70,
      noStyling: true,
      color: styler.appColor(0.5),
      margin: pad(p: 5.w, s: 'rtb'),
      padding: pad(l: 5.w, r: 5.w, t: 4.w, b: 2.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //
          Flexible(child: IntroType(feature: introFeatures[index])),
          //
          Wrap(
            children: List.generate(introFeatures.length, (index2) {
              return Planet(
                onPressed: () => setState(() => index = index2),
                isRound: true,
                noStyling: index != index2,
                child: AppIcon(Icons.circle, size: 6, extraFaded: index != index2),
              );
            }),
          ),
          //
        ],
      ),
    ).animate().fadeIn();
  }
}
