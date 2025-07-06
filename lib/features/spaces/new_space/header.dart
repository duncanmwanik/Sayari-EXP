import 'package:flutter/material.dart';

import '../../../_helpers/nav/navigation.dart';
import '../../../_services/cloud/sync/edit_item.dart';
import '../../../_state/_providers.dart';
import '../../../_widgets/buttons/action.dart';
import '../_helpers/create.dart';
import '../_helpers/names.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //
        ActionButton(isCancel: true),
        ActionButton(
          label: state.input.item.isNew ? 'Create' : 'Save',
          onPressed: () {
            if (state.input.item.isNew) {
              createSpace();
            } else {
              updateSpaceName(name: state.input.item.title());
              popWhatsOnTop(todoLast: () => editItem());
            }
          },
        ),
        //
      ],
    );
  }
}
