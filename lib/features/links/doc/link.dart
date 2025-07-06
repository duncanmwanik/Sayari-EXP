import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_widgets/files/cover.dart';
import '../../share/w_settings/shared.dart';
import 'add_link.dart';
import 'links.dart';
import 'socials.dart';

class Links extends StatelessWidget {
  const Links({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padN('t'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Cover(),
          mph(),
          ShareSettings(showEditor: true),
          mph(),
          Socials(),
          //
          LinksList(),
          AddLink(),
          //
        ],
      ),
    );
  }
}
