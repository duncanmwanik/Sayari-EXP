import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../_theme/spacing.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/dialogs/confirmation_dialog.dart';
import '../../_widgets/others/icons.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: kDebugMode,
      child: Padding(
        padding: padM('r'),
        child: Planet(
          onPressed: () async {
            // globalBox.put(appReset,   getUniqueId());
            // toastInfo( 'Did that...');
            await showConfirmationDialog(
              title: 'Do something?',
              content:
                  'This will do something bad. In your prefered location, create the folder `development` where we will store everything related to Flutter development',
              onAccept: () {},
            );
          },
          tooltip: 'Search',
          isSquare: true,
          noStyling: true,
          child: AppIcon(Icons.search_rounded, faded: true),
        ),
      ),
    );
  }
}
