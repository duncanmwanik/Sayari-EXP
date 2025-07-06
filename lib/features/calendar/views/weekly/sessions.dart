import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../_models/date.dart';
import '../../../../_models/item.dart';
import '../../../../_services/hive/store.dart';
import '../../../../_theme/variables.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/others/future.dart';
import '../../_helpers/prepare.dart';
import '../../_helpers/sort.dart';
import '../../_state/date.dart';
import 'box.dart';

class WeeklySessions extends StatelessWidget {
  const WeeklySessions({
    super.key,
    required this.indexHour,
    required this.isCurrentHour,
  });

  final int indexHour;
  final bool isCurrentHour;

  @override
  Widget build(BuildContext context) {
    return Consumer<DateProvider>(builder: (context, dates, child) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(7, (indexWeekDay) {
            DateItem date = DateItem(dates.weekDates[indexWeekDay]);

            return Expanded(
              child: Planet(
                onPressed: () => createSession(date: date, hour: indexHour),
                onDoublePress: () => createSession(date: date, hour: indexHour),
                onLongPress: () => createSession(date: date, hour: indexHour),
                mouseCursor: SystemMouseCursors.basic,
                padding: noPadding,
                width: double.maxFinite,
                height: 36.7,
                color: transparent,
                hoverColor: transparent,
                radius: 0,
                borderSide: Border(right: BorderSide(color: styler.borderColor(), width: 0.3)),
                child: ValueListenableBuilder(
                    valueListenable: local(features.calendar).listenable(keys: [date.datePart()]),
                    builder: (context, box, widget) {
                      return AppFuture(
                          future: sortSessions(date, hour: indexHour),
                          widget: (hourMap) {
                            return Column(
                              children: List.generate(hourMap.length, (indexSessionId) {
                                String id = hourMap.keys.toList()[indexSessionId];
                                Item item = Item(
                                  parent: features.calendar,
                                  type: features.calendar,
                                  id: date.datePart(),
                                  sid: id,
                                  data: hourMap[id],
                                );

                                return WeekBox(item: item);
                              }),
                            );
                          });
                    }),
              ),
            );
          }),
        ),
      );
    });
  }
}
