import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_widgets/others/scroll.dart';
import '../../share/w_shared/header.dart';
import 'booker.dart';
import 'extras.dart';
import 'intro.dart';

class BookingBody extends StatelessWidget {
  const BookingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (cx, cs) {
      return NoScrollBars(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              SharedHeader(showDivider: false),
              //
              SingleChildScrollView(
                padding: pad(),
                child: Row(
                  spacing: mw(),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BookingIntro(),
                        Booker(),
                      ],
                    ),
                    //
                    BookingExtras()
                    //
                  ],
                ),
              ),
              //
              lph(),
              //
            ],
          ),
        ),
      );
    });
  }
}
