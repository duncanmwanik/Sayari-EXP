import 'package:flutter/material.dart';

import '../../_state/_providers.dart';
import '../../_widgets/others/empty.dart';
import 'layout/column.dart';
import 'layout/grid.dart';

class DocsBuilder extends StatelessWidget {
  const DocsBuilder({
    super.key,
    this.ids = const [],
    this.isLoading = false,
  });
  final List ids;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ids.isEmpty && !isLoading
        ? EmptyBox(
            showImage: !state.views.isAlternateView(),
            label: 'No docs',
          )
        : state.views.isColumn() && !state.views.isAlternateView()
            ? ColumnLayout(ids: ids, isLoading: isLoading)
            : GridLayout(ids: ids, isLoading: isLoading);
  }
}
