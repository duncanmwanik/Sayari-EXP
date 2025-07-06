import '../extentions/date_time.dart';

Future<Map<int, String>> getMonthDateMap(int year, int month) async {
  Map<int, String> monthDatesMap = {};
  Future.microtask(() {
    DateTime firstDay = DateTime.utc(year, month, 1);
    int firstDateIndex = firstDay.weekday;
    for (int i = firstDateIndex; i > 0; i--) {
      monthDatesMap[firstDateIndex - i] = firstDay.subtract(Duration(days: i)).datePart();
    }
    int remainingDays = 42 - monthDatesMap.length;
    for (int i = 0; i < remainingDays; i++) {
      monthDatesMap[monthDatesMap.length] = firstDay.add(Duration(days: i)).datePart();
    }
  });

  return monthDatesMap;
}
