import '../../_services/hive/boxes.dart';
import '../../_state/_providers.dart';

Future delay(int milliseconds) async => await Future.delayed(Duration(milliseconds: milliseconds));
void showSyncingLoader(bool show) => globalBox.put('showUpdateLoader', show);
bool isShare() => state.share.isSharedView;
