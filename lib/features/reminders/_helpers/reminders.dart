Map reminderPeriodsMap = {'m': 'minutes', 'h': 'hours', 'd': 'days', 'w': 'weeks'};
Map periodMinutes = {'m': 1, 'h': 60, 'd': 1440, 'w': 10080};

int reminderTimeInMinutes(String reminder) {
  try {
    int number = int.parse(reminder.split('.')[0]);
    int periodMinute = periodMinutes[reminder.split('.')[1]];
    return number * periodMinute;
  } catch (e) {
    return 30;
  }
}
