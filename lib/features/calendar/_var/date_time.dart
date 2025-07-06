// list of days of the week objects

// day object
class DayObject {
  const DayObject(
      {required this.number, required this.name, required this.shortName, required this.shortNameCap, required this.superShortName});
  final int number;
  final String name;
  final String shortName;
  final String shortNameCap;
  final String superShortName;
}

const List<DayObject> weekDaysList = [
  DayObject(number: 0, name: 'Sunday', shortName: 'Sun', shortNameCap: 'SUN', superShortName: 'S'),
  DayObject(number: 1, name: 'Monday', shortName: 'Mon', shortNameCap: 'MON', superShortName: 'M'),
  DayObject(number: 2, name: 'Tuesday', shortName: 'Tue', shortNameCap: 'TUE', superShortName: 'T'),
  DayObject(number: 3, name: 'Wednesday', shortName: 'Wed', shortNameCap: 'WED', superShortName: 'W'),
  DayObject(number: 4, name: 'Thursday', shortName: 'Thu', shortNameCap: 'THU', superShortName: 'T'),
  DayObject(number: 5, name: 'Friday', shortName: 'Fri', shortNameCap: 'FRI', superShortName: 'F'),
  DayObject(number: 6, name: 'Saturday', shortName: 'Sat', shortNameCap: 'SAT', superShortName: 'S'),
];
