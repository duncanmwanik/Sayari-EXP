import 'package:flutter/services.dart';

import '../../_state/_providers.dart';
import '../../_theme/variables.dart';
import '../extentions/strings.dart';

void setWindowTitle(String title) {
  SystemChrome.setApplicationSwitcherDescription(
    ApplicationSwitcherDescription(label: title, primaryColor: styler.accent().value),
  );
}

void resetWindowTitle() => setWindowTitle(state.views.view.cap());
