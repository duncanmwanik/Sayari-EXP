import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/menu/model.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_state/date.dart';

class ViewChooser extends StatelessWidget {
  const ViewChooser({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateProvider>(builder: (context, dates, child) {
      return Planet(
        menu: Menu(
          width: 150,
          items: [
            // daily
            if (dates.calendarId.isCalendar())
              MenuItem(
                label: dailyView.cap(),
                trailing: Icons.view_carousel_outlined,
                isSelected: dates.isDay(),
                onTap: () async {
                  if (!dates.isDay()) dates.setCalendarView(dailyView);
                  if (!dates.calendarId.isCalendar()) state.input.update(itemHabitView, dailyView);
                },
              ),
            // weekly
            if (dates.calendarId.isCalendar())
              MenuItem(
                label: weeklyView.cap(),
                leadingSize: 14,
                trailing: Icons.view_week,
                isSelected: dates.isWeek(),
                onTap: () async {
                  if (!dates.isWeek()) dates.setCalendarView(weeklyView);
                  if (!dates.calendarId.isCalendar()) state.input.update(itemHabitView, weeklyView);
                },
              ),
            // monthly
            MenuItem(
              label: monthlyView.cap(),
              trailing: Icons.calendar_month_rounded,
              isSelected: dates.isMonth(),
              onTap: () async {
                if (!dates.isMonth()) dates.setCalendarView(monthlyView);
                if (!dates.calendarId.isCalendar()) state.input.update(itemHabitView, monthlyView);
              },
            ),
            // year
            MenuItem(
              label: yearlyView.cap(),
              trailing: Icons.view_compact_sharp,
              isSelected: dates.isYear(),
              onTap: () async {
                if (!dates.isYear()) dates.setCalendarView(yearlyView);
                if (!dates.calendarId.isCalendar()) state.input.update(itemHabitView, yearlyView);
              },
            ),
          ],
        ),
        srp: true,
        svp: true,
        showBorder: true,
        noStyling: true,
        radius: borderRadiusLarge,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: AppText(dates.calendarView.cap())),
            tpw(),
            AppIcon(dropIcon, faded: true, size: normal),
          ],
        ),
      );
    });
  }
}
