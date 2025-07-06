import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../_models/item.dart';
import '../../_theme/spacing.dart';
import 'new_list.dart';
import 'view.dart';

class Kanban extends StatelessWidget {
  const Kanban({super.key, this.doc});

  final Item? doc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padM('t'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Align(
            alignment: Alignment.topRight,
            child: NewList(),
          ),
          //
          KanbanView(doc: doc),
          //
        ],
      ).animate().fadeIn(),
    );
  }
}
