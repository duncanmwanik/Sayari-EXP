import 'package:flutter/material.dart';

import 'shared_note.dart';

class SharedView extends StatelessWidget {
  const SharedView({super.key, required this.params});
  final String params;

  @override
  Widget build(BuildContext context) {
    return SharedNote(params: params);
    // return isSpace ? SharedSpace(params: params) : SharedNote(params: params);
  }
}
