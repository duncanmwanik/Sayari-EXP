import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../../_models/date.dart';
import '../../../../_models/item.dart';
import '../../../../_services/hive/store.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/others/future.dart';
import '../../_helpers/sort.dart';
import 'box.dart';

class DailySessions extends StatelessWidget {
  const DailySessions({
    super.key,
    required this.date,
    this.indexHour,
    this.emptyWidget,
  });

  final DateItem date;
  final int? indexHour;
  final Widget? emptyWidget;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: local(features.calendar).listenable(keys: [date.datePart()]),
        builder: (context, box, widget) {
          return AppFuture(
              future: sortSessions(date, hour: indexHour),
              widget: (sessions) {
                if (emptyWidget != null && sessions.isEmpty) {
                  return emptyWidget!;
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(sessions.length, (int indexSessionId) {
                    String id = sessions.keys.toList()[indexSessionId];

                    return DayBox(
                      item: Item(
                        parent: features.calendar,
                        type: features.calendar,
                        id: date.datePart(),
                        sid: id,
                        data: sessions[id],
                      ),
                    );
                  }),
                );
              });
        });
  }
}
