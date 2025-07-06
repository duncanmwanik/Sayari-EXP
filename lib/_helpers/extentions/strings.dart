import 'package:flutter/material.dart';

import '../../_models/date.dart';
import '../../_variables/constants.dart';
import '../common/global.dart';
import '../ui/string_to_color.dart';
import 'date_time.dart';

extension StringExtentions on String {
  String cap() => length > 1 ? '${this[0].toUpperCase()}${substring(1)}' : toUpperCase();
  String singular() => endsWith('s') ? substring(0, length - 1) : this;
  String fewWords() => (length > 30 ? '${substring(0, 30)}...' : this);
  String naked() => replaceAll(RegExp('[^A-Za-z0-9]'), '_'); // email
  String bare() => replaceAll(RegExp('[^A-Za-z0-9_]'), '_'); // links
  Color toColor() => stringToColor(this);

  bool isValid() => trim().isNotEmpty;
  bool isFile([bool showHidden = true]) {
    if (showHidden) {
      return startsWith(itemFile) || startsWith(itemFileCover) || startsWith(itemFileHidden);
    } else {
      return startsWith(itemFile);
    }
  }

  // finance
  bool isIncome() => this == itemIncome;
  bool isExpense() => this == itemExpense;
  bool isSaving() => this == itemSaving;
  String financeTitle() => isIncome() ? 'Income' : (isExpense() ? 'Expense' : 'Saving');
  String financesTitle() => isIncome() ? 'Income' : (isExpense() ? 'Expenses' : 'Savings');
  Color financeColor() => isIncome() ? incomeColor : (isExpense() ? expenseColor : savingColor);
  IconData financeIcon() => isIncome() ? Icons.add_rounded : (isExpense() ? Icons.remove_rounded : Icons.savings);
  String toCurrency() => 'Ksh. $this';

  // date & time
  DateTime dateTime() => DateTime.tryParse(this) ?? now();
  String datePart() => dateTime().datePart();
  String timePart() => dateTime().timePart();
  String stampToTime([bool short = true]) {
    DateItem date = DateItem(DateTime.fromMillisecondsSinceEpoch(int.parse(this)).format());
    return short ? date.dateInfo() : date.info();
  }

  bool hasDatePart() => RegExp(r'\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])').firstMatch(this) != null;
  bool hasTimePart() => RegExp(r'([0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]').firstMatch(this) != null;
  bool isDatePlusTime() => hasDatePart() && hasTimePart();
}

// get color from string
