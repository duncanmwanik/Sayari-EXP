import 'package:flutter/material.dart';

import '../../../_helpers/common/global.dart';
import '../../../_helpers/date_time/weeks.dart';
import '../../../_models/date.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';

class DateProvider with ChangeNotifier {
  DateItem date = DateItem.now();

  void updateDate(String newDateTime) {
    date = DateItem(newDateTime);
    notifyListeners();
  }

  // holds week dates
  List<String> weekDates = getWeekDates(now());

  void updateWeekDates(DateTime newDate) {
    weekDates = getWeekDates(newDate);
  }

  // calendar view
  String calendarView = globalBox.get('${features.calendar}_view', defaultValue: monthlyView);
  String calendarId = features.calendar;

  bool isDay() => calendarView == dailyView;
  bool isWeek() => calendarView == weeklyView;
  bool isMonth() => calendarView == monthlyView;
  bool isYear() => calendarView == yearlyView;

  void initCalendarView(String id, [String? view]) {
    date = DateItem.now();
    calendarId = id;
    calendarView = view ?? globalBox.get('${id}_view', defaultValue: monthlyView);
  }

  void setCalendarView(String view) {
    calendarView = view;
    globalBox.put('${calendarId}_view', view);
    notifyListeners();
  }
}
