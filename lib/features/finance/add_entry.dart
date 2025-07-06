import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../_helpers/extentions/strings.dart';
import '../../_helpers/nav/navigation.dart';
import '../../_models/item.dart';
import '../../_state/_providers.dart';
import '../../_state/input.dart';
import '../../_state/temp.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/action.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/dialogs/app_dialog.dart';
import '../../_widgets/files/_helpers/get_files.dart';
import '../../_widgets/forms/input.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '../../_widgets/others/toast.dart';
import '../notes/w/picker_type.dart';
import '_vars/variables.dart';

Future showFinanceEntryDialog(Item entry) {
  TextEditingController amountController = TextEditingController(
    text: entry.hasAmount() ? entry.amount().toString() : null,
  );
  TextEditingController descriptionController = TextEditingController(text: entry.content());

  state.temp.set(entry.typee());

  return showAppDialog(
    //
    title: '${entry.isNew ? 'Add' : 'Edit'} ${entry.type.financeTitle()}',
    //
    content: Consumer<InputProvider>(builder: (context, input, child) {
      return SingleChildScrollView(
        padding: padT('tb'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // amount input
            Row(
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
            // description input
            DataInput(
              controller: descriptionController,
              hintText: 'Description',
              minLines: 2,
              textCapitalization: TextCapitalization.sentences,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: padS('t'),
              showBorder: true,
            ),
            sph(),
            //
            Row(
              children: [
                // type
                Consumer<TempProvider>(builder: (context, temp, child) {
                  return AppTypePicker(
                    type: features.finances,
                    subType: entry.type,
                    initial: temp.temp,
                    typeEntries:
                        entry.type.isIncome() ? financeIncomeTypes : (entry.type.isExpense() ? financeExpenseTypes : financeSavingTypes),
                    onSelect: (chosenType, chosenValue) => state.temp.set(chosenType),
                  );
                }),
                // add files
                Planet(
                  onPressed: () async => await getFilesToUpload(addToInput: false).then((stash) {}),
                  tooltip: 'Attach File',
                  noStyling: true,
                  isSquare: true,
                  margin: padM('l'),
                  child: AppIcon(Icons.attach_file_rounded, faded: true, size: 18),
                ),
                // /
              ],
            ),
            //
          ],
        ),
      );
    }),
    //
    actions: [
      //
      ActionButton(isCancel: true),
      ActionButton(
        label: entry.isNew ? 'Add' : 'Save',
        onPressed: () async {
          if (amountController.text.isValid()) {
            state.input.update(itemAmount, double.parse(amountController.text), parentKey: entry.id);
            state.input.update(itemContent, descriptionController.text, parentKey: entry.id);
            state.input.update(itemType, state.temp.temp, parentKey: entry.id);
            popWhatsOnTop();
          } else {
            toastError('Enter amount');
          }
        },
      ),
      //
    ],
    //
  );
}
