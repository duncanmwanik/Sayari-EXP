import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/input.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/others/color.dart';
import '../../../_widgets/others/color_menu.dart';

class SessionColor extends StatelessWidget {
  const SessionColor({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return ColorButton(
        menu: colorMenu(
          selectedColor: input.item.data[itemColor],
          onSelect: (newColor) => input.update(itemColor, newColor),
        ),
        color: input.item.data[itemColor],
      );
    });
  }
}
