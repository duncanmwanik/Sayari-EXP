import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../../_models/date.dart';
import '../../../../_models/item.dart';
import '../../../../_services/hive/store.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/others/future.dart';
import '../../_helpers/sort.dart';
import 'box.dart';

class MonthDateSessions extends StatelessWidget {
  const MonthDateSessions({super.key, required this.date});

  final DateItem date;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: local(features.calendar).listenable(keys: [date.datePart()]),
        builder: (context, box, widget) {
          return AppFuture(
              future: sortSessions(date),
              widget: (todaySessionsMap) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(
                      todaySessionsMap.length,
                      (index) {
                        String id = todaySessionsMap.keys.toList()[index];
                        Item item = Item(
                          parent: features.calendar,
                          type: features.calendar,
                          id: date.datePart(),
                          sid: id,
                          data: todaySessionsMap[id],
                        );

                        return MonthBox(item: item);
                      },
                    ),
                  ),
                );
              });
        });
  }
}
