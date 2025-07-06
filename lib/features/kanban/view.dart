import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_models/item.dart';
import '../../_state/input.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/future.dart';
import '../../_widgets/rebuilders/length_type.dart';
import '_helpers/get_lists.dart';
import 'lists.dart';

class KanbanView extends StatelessWidget {
  const KanbanView({super.key, this.doc});

  final Item? doc;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return LengthRebuilderType(
        types: features.docTypes(),
        builder: () => AppFuture(
          future: getListIds(),
          errorWidget: KanbanLists(isLoading: true, listIds: [], doc: doc),
          loadingWidget: KanbanLists(isLoading: true, listIds: [], doc: doc),
          widget: (data) => KanbanLists(listIds: data, doc: doc),
        ),
      );
    });
  }
}
