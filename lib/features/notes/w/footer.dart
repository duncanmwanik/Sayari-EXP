import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/input.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';

class NoteFooter extends StatelessWidget {
  const NoteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Visibility(
        visible: input.item.showFooter(),
        child: Planet(
          width: double.maxFinite,
          color: styler.primaryColor(),
          padding: noPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  //
                  // if (!state.views.isAlternateView())
                  //   Expanded(
                  //     child: LastEdit(timestamp: input.item.data[itemTimestamp]),
                  //   ),
                  //
                  // NoteFormarttingButton(),
                  //
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
