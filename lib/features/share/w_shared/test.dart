import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/theme.dart';
import '../../../_theme/background.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/others/icons.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key, this.params});
  final String? params;

  @override
  State<TestScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, theme, child) {
        return AppBackground(
          child: SafeArea(
            child: Scaffold(
              backgroundColor: transparent,
              body: SingleChildScrollView(
                padding: pad(p: tw()),
                child: Wrap(
                  spacing: mw(),
                  runSpacing: mw(),
                  children: List.generate(2550, (index) {
                    return AppIcon(Icons.circle, size: 6, extraFaded: true);
                  }),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
