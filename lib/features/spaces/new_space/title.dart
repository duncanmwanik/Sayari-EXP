import 'package:flutter/material.dart';

import '../../../_state/_providers.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/forms/input.dart';

class TitleInput extends StatelessWidget {
  const TitleInput({super.key});

  @override
  Widget build(BuildContext context) {
    return DataInput(
      inputKey: itemTitle,
      hintText: 'Space Name',
      autofocus: state.input.item.isNew,
      fontSize: title,
      weight: ft6,
      keyboardType: TextInputType.name,
      clean: true,
    );
  }
}
