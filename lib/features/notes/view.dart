import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_state/views.dart';
import '../../_variables/features.dart';
import '../../_widgets/others/future.dart';
import '../../_widgets/rebuilders/length_type.dart';
import '_helpers/chosen.dart';
import 'builder.dart';
import 'state/active.dart';

class DocView extends StatelessWidget {
  const DocView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ViewsProvider, DocProvider>(builder: (context, views, doc, child) {
      return LengthRebuilderType(
        types: features.docTypes(),
        builder: () => AppFuture(
          future: getChosenItems(features.docTypes()),
          errorWidget: DocsBuilder(isLoading: true),
          loadingWidget: DocsBuilder(isLoading: true),
          widget: (data) => DocsBuilder(ids: data),
        ),
      );
    });
  }
}
