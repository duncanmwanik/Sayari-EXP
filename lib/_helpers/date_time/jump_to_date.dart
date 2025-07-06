import '../../_state/_providers.dart';
import '../../_widgets/datepicker/sfcalendar.dart';
import '../../_widgets/menu/model.dart';
import '../extentions/date_time.dart';

Future<void> jumpToDate(DateTime? date) async {
  if (date != null) {
    state.dates.updateDate(date.datePart());
  }
}

Menu jumpToDateMenu(Function(DateTime)? onSelect) {
  return Menu(
    items: [
      SfCalendar(onSelect: onSelect),
    ],
  );
}
