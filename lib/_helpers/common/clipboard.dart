import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../_variables/constants.dart';
import '../../_widgets/others/toast.dart';
import '../debug/debug.dart';

Future<void> copyText(String text, {String? description, bool toast = true}) async {
  try {
    if (kDebugMode) text = text.replaceAll(sayariDefaultPath, sayariDebugPath);
    await Clipboard.setData(ClipboardData(text: text)).then((value) {
      if (toast) toastSuccess(description ?? 'Copied link.');
    });
  } catch (e) {
    logError('copyText', e);
  }
}
