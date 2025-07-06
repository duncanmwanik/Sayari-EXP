import '../../../_helpers/common/global.dart';
import '../../../_helpers/common/internet.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_services/cloud/sync_to_cloud.dart';
import '../../../_services/hive/store.dart';
import '../../../_services/hive/sync_to_local.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/others/toast.dart';
import '../../auth/_helpers/error.dart';
import 'helpers.dart';

Future<void> editUsername(String newUsername) async {
  isBusy(true);
  try {
    if (await isOffline()) return;
    await local(info, space: liveUser()).putAll({itemUsername: newUsername});
    await syncToLocal(space: liveUser(), parent: info, action: 'c', key: itemUsername, value: newUsername);
    await syncToCloud(space: liveUser(), parent: info, action: 'c', key: itemUsername, value: newUsername);
    closeDialog();
    toastSuccess('Your name has been changed.');
  } catch (e) {
    toastError(handleOtherErrors(e, process: 'change name'));
  }
  isBusy(false);
}
