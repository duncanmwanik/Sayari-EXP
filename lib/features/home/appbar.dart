import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_state/views.dart';
import '../../_theme/breakpoints.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/other.dart';
import '../calendar/views/header.dart';
import '../chat/w/filters_menu.dart';
import '../notes/actions/selection.dart';
import '../notes/state/selection.dart';
import '../notes/w/note_options.dart';
import '../user/dp.dart';
import '../user/user_menu.dart';
import 'panel/space.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<SelectionProvider, ViewsProvider>(builder: (context, selection, views, child) {
      bool isItemSelection = selection.isSelection;

      return Planet(
        noStyling: true,
        padding: !isSmallPC() || isItemSelection || views.isCalendar() ? padM() : noPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            if (isItemSelection) SelectedItemOptions(),
            //
            if (!isSmallPC() && !isItemSelection)
              Planet(
                padding: noPadding,
                noStyling: true,
                child: Row(
                  children: [
                    //
                    if (!isSmallPC()) UserDp(menu: userMenu()),
                    // space
                    SpaceName(),
                    // options
                    Expanded(
                      child: views.isDocs()
                          ? NoteOptions()
                          : views.isChat()
                              ? ChatFiltersMenu()
                              : NoWidget(),
                    ),
                    // actions
                    //
                  ],
                ),
              ),
            //
            if (views.isCalendar()) CalendarHeader(),
            //
          ],
        ),
      );
    });
  }
}
