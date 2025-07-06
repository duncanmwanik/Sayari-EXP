import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_models/item.dart';
import '../../../_state/input.dart';
import '../../../_widgets/files/file_list.dart';
import '../../reminders/reminder.dart';
import '../../tags/tag_list.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    if (item.isInput) {
      return Consumer<InputProvider>(builder: (x, input, c) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (input.item.hasReminder()) Reminder(item: input.item),
            if (input.item.hasTags()) TagList(item: input.item),
            if (input.item.hasFiles()) FileList(item: input.item),
          ],
        );
      });
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.hasReminder()) Reminder(item: item),
          if (item.hasTags()) TagList(item: item),
          if (item.hasFiles()) FileList(item: item, isOverview: true),
        ],
      );
    }
  }
}
