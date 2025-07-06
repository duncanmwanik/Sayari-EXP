import '../../../_models/date.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';

Future<Map> sortSessions(DateItem date, {int? hour}) async {
  Map sessionsMap = {...local(features.calendar).get(date.datePart(), defaultValue: {})};
  List<MapEntry> entries = sessionsMap.entries.toList()..sort((a, b) => (a.value[itemStart]).compareTo((b.value[itemStart])));
  sessionsMap = {for (var entry in entries) entry.key: entry.value};

  if (hour != null) {
    sessionsMap.removeWhere((key, value) {
      return DateItem(value[itemStart]).hour() != hour;
    });
  }

  return sessionsMap;
}
