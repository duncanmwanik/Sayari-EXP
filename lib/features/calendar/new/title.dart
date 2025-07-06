import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/forms/input.dart';

class NewSessionTitle extends StatelessWidget {
  const NewSessionTitle({
    super.key,
    required this.isNew,
  });

  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padC('l2,t8,b6'),
      child: DataInput(
        inputKey: itemTitle,
        hintText: 'Title',
        fontSize: large,
        contentPadding: padL('b'),
        maxLines: 3,
        weight: FontWeight.bold,
        keyboardType: TextInputType.name,
        clean: true,
        autofocus: isNew,
      ),
    );
  }
}
