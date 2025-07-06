import 'package:flutter/material.dart';

import '../../_models/item.dart';
import '../../_widgets/others/future.dart';
import '_helpers/get_lists.dart';
import 'lists.dart';

class KanbanOverview extends StatelessWidget {
  const KanbanOverview({super.key, required this.doc});

  final Item doc;

  @override
  Widget build(BuildContext context) {
    return AppFuture(
      future: getListIds(doc),
      errorWidget: KanbanLists(isLoading: true, listIds: [], doc: doc),
      loadingWidget: KanbanLists(isLoading: true, listIds: [], doc: doc),
      widget: (data) => KanbanLists(listIds: data, doc: doc),
    );
  }
}
