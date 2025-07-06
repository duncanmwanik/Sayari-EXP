import '../../../_helpers/debug/debug.dart';
import '../../../_services/cloud/storage.dart';
import '../../../_services/cloud/sync.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/files/_helpers/download.dart';
import '../../../_widgets/files/_helpers/get_files.dart';
import '../../../_widgets/files/_helpers/helper.dart';
import '../../../_widgets/files/model.dart';
import '../../../_widgets/files/viewer.dart';
import 'helpers.dart';

Future<void> chooseUserDp() async {
  try {
    await getFilesToUpload(
      single: true,
      addToInput: false,
      imagesOnly: true,
      onDone: (stash) async {
        if (hasUserDp()) await removeUserDp();
        FileItem file = stash.first();
        String dp = getCloudFileName(file.id, file.name);
        await storage.uploadFile(db: users, parent: liveUser(), id: file.id, name: file.name);
        await sync.create(db: users, space: liveUser(), parent: 'info', id: itemUserDp, value: dp);
        userInfoBox.put(itemUserDp, dp);
      },
    );
  } catch (e) {
    logError('chooseUserDp', e);
  }
}

Future<void> removeUserDp() async {
  try {
    await storage.deleteFile(db: users, parent: liveUser(), id: userDpId(), name: userDpName());
    await sync.delete(db: users, space: liveUser(), parent: 'info', id: itemUserDp);
    userInfoBox.delete(itemUserDp);
  } catch (e) {
    logError('removeUserDp', e);
  }
}

void showDpImageViewer() {
  showImageViewer(
    images: {userDpId(): userDpName()},
    onDownload: () async => await downloadFile(
      db: users,
      id: userDpId(),
      name: userDpName(),
      cloudFilePath: '${liveUser()}/${userDpName()}',
      downloadPath: userDpName(),
    ),
  );
}
