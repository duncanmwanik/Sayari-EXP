import '../../../_helpers/keyboard/keyboard.dart';
import '../../../_services/activity/listen/helpers.dart';
import '../../../_services/activity/pending/retry_pending_actions.dart';
import '../../../_state/_providers.dart';

void initializeHome() {
  state.share.unset();
  doPendingSync();
  keyboard.listen();
  initializeUserSync();
}

void unInitializeHome() {
  disposeSpaceSync();
  disposeUserSync();
  keyboard.cancel();
}
