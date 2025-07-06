import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:web/web.dart' as web;

void initializeMisc() {
  usePathUrlStrategy();
  web.document.body?.style.overscrollBehaviorX = 'none';
}
