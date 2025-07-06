import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';

class ScrollChatsButton extends StatefulWidget {
  const ScrollChatsButton({super.key});

  @override
  State<ScrollChatsButton> createState() => _ScrollChatsButtonState();
}

class _ScrollChatsButtonState extends State<ScrollChatsButton> {
  bool visible = false;

  @override
  void initState() {
    // chatScrollController.addListener(listenForScrollEntent);
    super.initState();
  }

  void listenForScrollEntent() {
    // if (chatScrollController.offset > 80.h) {
    //   if (!visible) setState(() => visible = true);
    // } else {
    //   if (visible) setState(() => visible = false);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Planet(
        margin: padM('b'),
        // onPressed: () => chatScrollController.animateTo(
        //   chatScrollController.position.minScrollExtent,
        //   curve: Curves.easeOut,
        //   duration: const Duration(milliseconds: 100),
        // ),
        height: 45,
        width: 45,
        isRound: true,
        child: AppIcon(Icons.arrow_downward_rounded, extraFaded: true),
      ),
    );
  }
}
