import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/input.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../../notes/w/picker_type.dart';
import '../_var/variables.dart';

class TypePicker extends StatelessWidget {
  const TypePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return AppTypePicker(
        type: features.calendar,
        subType: itemType,
        initial: input.item.typee(),
        typeEntries: sessionsTypes,
        color: transparent,
        showNew: true,
        onSelect: (chosenType, chosenValue) => input.update(itemType, chosenType),
      );
    });
  }
}
