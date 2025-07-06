import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../_helpers/extentions/strings.dart';
import '../../_helpers/nav/navigation.dart';
import '../../_state/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_widgets/buttons/action.dart';
import '../../_widgets/dialogs/app_dialog.dart';
import '../../_widgets/forms/input.dart';
import '../../_widgets/others/text.dart';
import '../../_widgets/others/toast.dart';

Future showSetGoalDialog(String type) {
  bool hasGoal = state.input.item.goal(type) > 0;
  TextEditingController amountController = TextEditingController(
    text: state.input.item.goal(type) > 0 ? state.input.item.goal(type).toString() : null,
  );

  return showAppDialog(
    //
    title: '${hasGoal ? 'Edit' : 'Set'} ${type.financeTitle()} Goal',
    //
    content: Row(
      children: [
        AppText('Ksh.', size: mediumNormal, faded: true),
        tpw(),
        Expanded(
          child: DataInput(
            controller: amountController,
            hintText: 'Amount',
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            autofocus: true,
            showBorder: true,
          ),
        ),
      ],
    ),
    //
    actions: [
      ActionButton(isCancel: true),
      ActionButton(
        label: hasGoal ? 'Save' : 'Set',
        onPressed: () async {
          if (!amountController.text.isValid() || double.parse(amountController.text) <= 0) {
            toastError('Enter amount');
            return;
          }

          state.input.update('$itemGoal$type', double.parse(amountController.text));
          popWhatsOnTop();
        },
      ),
    ],
  );
}
