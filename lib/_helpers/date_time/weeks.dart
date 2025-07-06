import '../extentions/date_time.dart';

List<String> getWeekDates(DateTime date) {
  int dateNo = date.weekday;

  if (dateNo == 1) {
    return [
      date.subtract(const Duration(days: 1)).datePart(),
      date.datePart(),
      date.add(const Duration(days: 1)).datePart(),
      date.add(const Duration(days: 2)).datePart(),
      date.add(const Duration(days: 3)).datePart(),
      date.add(const Duration(days: 4)).datePart(),
      date.add(const Duration(days: 5)).datePart(),
    ];
  }
  if (dateNo == 2) {
    return [
      date.subtract(const Duration(days: 2)).datePart(),
      date.subtract(const Duration(days: 1)).datePart(),
      date.datePart(),
      date.add(const Duration(days: 1)).datePart(),
      date.add(const Duration(days: 2)).datePart(),
      date.add(const Duration(days: 3)).datePart(),
      date.add(const Duration(days: 4)).datePart(),
    ];
  }
  if (dateNo == 3) {
    return [
      date.subtract(const Duration(days: 3)).datePart(),
      date.subtract(const Duration(days: 2)).datePart(),
      date.subtract(const Duration(days: 1)).datePart(),
      date.datePart(),
      date.add(const Duration(days: 1)).datePart(),
      date.add(const Duration(days: 2)).datePart(),
      date.add(const Duration(days: 3)).datePart(),
    ];
  }
  if (dateNo == 4) {
    return [
      date.subtract(const Duration(days: 4)).datePart(),
      date.subtract(const Duration(days: 3)).datePart(),
      date.subtract(const Duration(days: 2)).datePart(),
      date.subtract(const Duration(days: 1)).datePart(),
      date.datePart(),
      date.add(const Duration(days: 1)).datePart(),
      date.add(const Duration(days: 2)).datePart(),
    ];
  }
  if (dateNo == 5) {
    return [
      date.subtract(const Duration(days: 5)).datePart(),
      date.subtract(const Duration(days: 4)).datePart(),
      date.subtract(const Duration(days: 3)).datePart(),
      date.subtract(const Duration(days: 2)).datePart(),
      date.subtract(const Duration(days: 1)).datePart(),
      date.datePart(),
      date.add(const Duration(days: 1)).datePart(),
    ];
  }
  if (dateNo == 6) {
    return [
      date.subtract(const Duration(days: 6)).datePart(),
      date.subtract(const Duration(days: 5)).datePart(),
      date.subtract(const Duration(days: 4)).datePart(),
      date.subtract(const Duration(days: 3)).datePart(),
      date.subtract(const Duration(days: 2)).datePart(),
      date.subtract(const Duration(days: 1)).datePart(),
      date.datePart(),
    ];
  }
  if (dateNo == 7) {
    return [
      date.datePart(),
      date.add(const Duration(days: 1)).datePart(),
      date.add(const Duration(days: 2)).datePart(),
      date.add(const Duration(days: 3)).datePart(),
      date.add(const Duration(days: 4)).datePart(),
      date.add(const Duration(days: 5)).datePart(),
      date.add(const Duration(days: 6)).datePart(),
    ];
  }

  return [];
}
